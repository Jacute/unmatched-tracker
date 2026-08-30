#include "../log.h"
#include "db.h"

#include <QSqlError>
#include <QSqlQuery>

Rc Database::getHeroGamesAndWins(quint64 heroId, quint64& games, quint64& wins) {
    const char op[] = "Database::getHeroGamesAndWins";
    QSqlQuery query(db);
    if (!query.prepare(
            "SELECT COUNT(*), "
            "COALESCE(SUM(CASE WHEN grp.team = gr.winning_team THEN 1 ELSE 0 END), 0) "
            "FROM game_record_participants grp "
            "JOIN game_records gr ON gr.id = grp.game_id "
            "WHERE grp.hero_id = :hero_id")) {
        logger_.error(op, "SQL prepare error", query.lastError().text());
        return Rc::ErrPrepareQuery;
    }

    query.bindValue(":hero_id", heroId);
    if (!query.exec()) {
        logger_.error(op, "SQL execute error", query.lastError().text());
        return Rc::ErrExecQuery;
    }

    if (query.next()) {
        games = query.value(0).toULongLong();
        wins = query.value(1).toULongLong();
    }
    return Rc::Ok;
}

Rc Database::getHeroWinRate(quint64 heroId, double& winRate) {
    const char op[] = "Database::getHeroWinRate";
    QSqlQuery query(db);
    if (!query.prepare(
            "SELECT CASE WHEN COUNT(*) = 0 THEN 0.0 "
            "ELSE SUM(CASE WHEN grp.team = gr.winning_team THEN 1.0 ELSE 0.0 END) "
            "* 100.0 / COUNT(*) END "
            "FROM game_record_participants grp "
            "JOIN game_records gr ON gr.id = grp.game_id "
            "WHERE grp.hero_id = :hero_id")) {
        logger_.error(op, "SQL prepare error", query.lastError().text());
        return Rc::ErrPrepareQuery;
    }

    query.bindValue(":hero_id", heroId);
    if (!query.exec()) {
        logger_.error(op, "SQL execute error", query.lastError().text());
        return Rc::ErrExecQuery;
    }

    if (query.next()) {
        winRate = query.value(0).toDouble();
    }
    return Rc::Ok;
}

Rc Database::getHeroAverageWinningHp(quint64 heroId, QVariant& averageHp) {
    const char op[] = "Database::getHeroAverageWinningHp";
    QSqlQuery query(db);
    if (!query.prepare(
            "SELECT AVG(ROUND(grp.hero_remaining_hp * 100.0 / h.hp, 1)) "
            "FROM game_record_participants grp "
            "JOIN game_records gr ON gr.id = grp.game_id "
            "JOIN heroes h ON h.id = grp.hero_id "
            "WHERE grp.hero_id = :hero_id "
            "AND grp.team = gr.winning_team "
            "AND grp.hero_remaining_hp IS NOT NULL")) {
        logger_.error(op, "SQL prepare error", query.lastError().text());
        return Rc::ErrPrepareQuery;
    }

    query.bindValue(":hero_id", heroId);
    if (!query.exec()) {
        logger_.error(op, "SQL execute error", query.lastError().text());
        return Rc::ErrExecQuery;
    }

    if (query.next()) {
        averageHp = query.value(0);
    }
    return Rc::Ok;
}

Rc Database::getHeroMatchups(quint64 heroId, QVector<models::HeroMatchup>& matchups) {
    const char op[] = "Database::getHeroMatchups";
    QSqlQuery query(db);
    if (!query.prepare(
            "SELECT opponent_hero.id, opponent_hero.name, opponent_hero.img_path, "
            "COUNT(*) AS games, "
            "100.0 * COALESCE(SUM(CASE WHEN hero.team = gr.winning_team THEN 1.0 ELSE 0.0 END), 0) "
            "/ COUNT(*) AS win_rate "
            "FROM game_record_participants hero "
            "JOIN game_record_participants opponent "
            "ON opponent.game_id = hero.game_id AND opponent.team != hero.team "
            "JOIN game_records gr ON gr.id = hero.game_id "
            "JOIN heroes opponent_hero ON opponent_hero.id = opponent.hero_id "
            "WHERE hero.hero_id = :hero_id AND gr.mode = '1v1' "
            "GROUP BY opponent_hero.id, opponent_hero.name, opponent_hero.img_path "
            "ORDER BY win_rate DESC, games DESC, opponent_hero.name COLLATE NOCASE")) {
        logger_.error(op, "matchups sql prepare error", {{"error", query.lastError().text()}});
        return Rc::ErrPrepareQuery;
    }

    query.bindValue(":hero_id", heroId);
    if (!query.exec()) {
        logger_.error(op, "matchups sql exec error", {{"error", query.lastError().text()}});
        return Rc::ErrExecQuery;
    }

    while (query.next()) {
        models::HeroMatchup matchup;
        matchup.opponentHeroId = query.value(0).toULongLong();
        matchup.opponentHeroName = query.value(1).toString();
        matchup.opponentHeroImgPath = query.value(2).toString();
        matchup.games = query.value(3).toULongLong();
        matchup.winRate = query.value(4).toDouble();
        matchups.push_back(std::move(matchup));
    }
    return Rc::Ok;
}

Rc Database::getProfileStats(const QString& profileId,
                             const QString& gameMode,
                             models::ProfileStats& stats) {
    const char op[] = "Database::getProfileStats";

    QSqlQuery profileQuery(db);
    if (!profileQuery.prepare("SELECT 1 FROM player_profiles WHERE id = :profile_id")) {
        logger_.error(op, "profile sql prepare error", {{"error", profileQuery.lastError().text()}});
        return Rc::ErrPrepareQuery;
    }
    profileQuery.bindValue(":profile_id", profileId);
    if (!profileQuery.exec()) {
        logger_.error(op, "profile sql exec error", {{"error", profileQuery.lastError().text()}});
        return Rc::ErrExecQuery;
    }
    if (!profileQuery.next()) {
        return Rc::ErrNotFound;
    }

    QSqlQuery totalsQuery(db);
    if (!totalsQuery.prepare(
            "SELECT COUNT(*), "
            "COALESCE(SUM(CASE WHEN grp.team = gr.winning_team THEN 1 ELSE 0 END), 0), "
            "AVG(CASE WHEN grp.team = gr.winning_team THEN ROUND(grp.hero_remaining_hp * 100.0 / h.hp, 1) END) "
            "FROM game_record_participants grp "
            "JOIN game_records gr ON gr.id = grp.game_id "
            "JOIN heroes h ON h.id = grp.hero_id "
            "WHERE grp.profile_id = :profile_id AND gr.mode = :game_mode")) {
        logger_.error(op, "totals sql prepare error", {{"error", totalsQuery.lastError().text()}});
        return Rc::ErrPrepareQuery;
    }
    totalsQuery.bindValue(":profile_id", profileId);
    totalsQuery.bindValue(":game_mode", gameMode);
    if (!totalsQuery.exec() || !totalsQuery.next()) {
        logger_.error(op, "totals sql exec error", {{"error", totalsQuery.lastError().text()}});
        return Rc::ErrExecQuery;
    }
    stats.gamesPlayed = totalsQuery.value(0).toULongLong();
    stats.gamesWon = totalsQuery.value(1).toULongLong();
    stats.averageWinningHp = totalsQuery.value(2);

    QSqlQuery heroQuery(db);
    if (!heroQuery.prepare(
            "SELECT h.id, h.name, h.img_path, COUNT(*) AS games_played, "
            "COALESCE(SUM(CASE WHEN grp.team = gr.winning_team THEN 1 ELSE 0 END), 0) "
            "AS games_won "
            "FROM game_record_participants grp "
            "JOIN game_records gr ON gr.id = grp.game_id "
            "JOIN heroes h ON h.id = grp.hero_id "
            "WHERE grp.profile_id = :profile_id AND gr.mode = :game_mode "
            "GROUP BY h.id, h.name, h.img_path "
            "ORDER BY games_played DESC, games_won DESC, h.name COLLATE NOCASE "
            "LIMIT 1")) {
        logger_.error(op, "hero sql prepare error", {{"error", heroQuery.lastError().text()}});
        return Rc::ErrPrepareQuery;
    }
    heroQuery.bindValue(":profile_id", profileId);
    heroQuery.bindValue(":game_mode", gameMode);
    if (!heroQuery.exec()) {
        logger_.error(op, "hero sql exec error", {{"error", heroQuery.lastError().text()}});
        return Rc::ErrExecQuery;
    }
    if (heroQuery.next()) {
        stats.favoriteHeroId = heroQuery.value(0).toULongLong();
        stats.favoriteHeroName = heroQuery.value(1).toString();
        stats.favoriteHeroImgPath = heroQuery.value(2).toString();
        stats.favoriteHeroGames = heroQuery.value(3).toULongLong();
        stats.favoriteHeroWins = heroQuery.value(4).toULongLong();
    }

    QSqlQuery mapQuery(db);
    if (!mapQuery.prepare("SELECT m.id, m.name, m.img_path, COUNT(*) AS games_played "
                          "FROM game_record_participants grp "
                          "JOIN game_records gr ON gr.id = grp.game_id "
                          "JOIN maps m ON m.id = gr.map_id "
                          "WHERE grp.profile_id = :profile_id AND gr.mode = :game_mode "
                          "GROUP BY m.id, m.name, m.img_path "
                          "ORDER BY games_played DESC, m.name COLLATE NOCASE "
                          "LIMIT 1")) {
        logger_.error(op, "map sql prepare error", {{"error", mapQuery.lastError().text()}});
        return Rc::ErrPrepareQuery;
    }
    mapQuery.bindValue(":profile_id", profileId);
    mapQuery.bindValue(":game_mode", gameMode);
    if (!mapQuery.exec()) {
        logger_.error(op, "map sql exec error", {{"error", mapQuery.lastError().text()}});
        return Rc::ErrExecQuery;
    }
    if (mapQuery.next()) {
        stats.favoriteMapId = mapQuery.value(0).toULongLong();
        stats.favoriteMapName = mapQuery.value(1).toString();
        stats.favoriteMapImgPath = mapQuery.value(2).toString();
        stats.favoriteMapGames = mapQuery.value(3).toULongLong();
    }

    return Rc::Ok;
}

Rc Database::getProfileHeroStats(const quint64& id, const QString& profileId, const QString& gameMode, models::HeroStats& stats) {
    const char op[] = "Database::getHeroStats";

    QSqlQuery query(db);
    if (!query.prepare(
        "SELECT "
        "COUNT(*), "
        "COALESCE(SUM(CASE WHEN grp.team = gr.winning_team THEN 1 ELSE 0 END), 0) "
        "AS games_won, "
        "AVG(CASE WHEN grp.team = gr.winning_team THEN ROUND(grp.hero_remaining_hp * 100.0 / h.hp, 1) END), "
        "MIN(gr.played_at), "
        "MAX(gr.played_at) "
        "FROM game_record_participants grp "
        "JOIN game_records gr ON gr.id = grp.game_id "
        "JOIN heroes h ON h.id = grp.hero_id "
        "WHERE grp.hero_id = :hero_id AND grp.profile_id = :profile_id "
        "AND gr.mode = :mode"
    )) {
        logger_.error(op, "statistic sql prepare error", {{"error", query.lastError().text()}});
        return Rc::ErrPrepareQuery;
    }
    query.bindValue(":hero_id", id);
    query.bindValue(":profile_id", profileId);
    query.bindValue(":mode", gameMode);
    if (!query.exec()) {
        logger_.error(op, "hero found sql exec error", {{"error", query.lastError().text()}});
        return Rc::ErrExecQuery;
    }
    if (query.next()) {
        stats.games = query.value(0).toULongLong();
        stats.wins = query.value(1).toULongLong();
        stats.averageWinningHp = query.value(2).toULongLong();
        stats.firstPlayedAt = query.value(3).toString();
        stats.lastPlayedAt = query.value(4).toString();
    }
    query.finish();
    query.clear();

    if (!query.prepare("SELECT grp2.hero_id AS opponent_hero_id "
                       "FROM game_record_participants grp "
                       "JOIN game_record_participants grp2 "
                       "ON grp2.game_id = grp.game_id "
                       "AND grp2.hero_id != grp.hero_id "
                       "JOIN game_records gr ON grp.game_id = gr.id "
                       "WHERE grp.hero_id = :hero_id AND grp.profile_id = :profile_id "
                       "AND gr.mode = :mode")) {
        logger_.error(op, "sql prepare error", {{"error", query.lastError().text()}});
        return Rc::ErrPrepareQuery;
    }
    query.bindValue(":hero_id", id);
    query.bindValue(":profile_id", profileId);
    query.bindValue(":mode", gameMode);
    if (!query.exec()) {
        logger_.error(op, "hero found sql exec error", {{"error", query.lastError().text()}});
        return Rc::ErrExecQuery;
    }
    if (query.next()) {
        stats.mostPlayedEnemyId = query.value(3).toULongLong();
    }

    return Rc::Ok;
}
