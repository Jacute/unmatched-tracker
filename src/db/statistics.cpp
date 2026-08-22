#include "../log.h"
#include "db.h"

#include <QSqlError>
#include <QSqlQuery>

Rc Database::getProfileStats(const QString& profileId,
                             const QString& gameMode,
                             models::ProfileStats& stats) {
    const char op[] = "Database::getProfileStats";

    QSqlQuery profileQuery(db);
    if (!profileQuery.prepare("SELECT 1 FROM player_profiles WHERE id = :profile_id")) {
        lwarn(op) << "profile sql prepare error: " << profileQuery.lastError().text();
        return Rc::ErrPrepareQuery;
    }
    profileQuery.bindValue(":profile_id", profileId);
    if (!profileQuery.exec()) {
        lwarn(op) << "profile sql exec error: " << profileQuery.lastError().text();
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
        lwarn(op) << "totals sql prepare error: " << totalsQuery.lastError().text();
        return Rc::ErrPrepareQuery;
    }
    totalsQuery.bindValue(":profile_id", profileId);
    totalsQuery.bindValue(":game_mode", gameMode);
    if (!totalsQuery.exec() || !totalsQuery.next()) {
        lwarn(op) << "totals sql exec error: " << totalsQuery.lastError().text();
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
        lwarn(op) << "hero sql prepare error: " << heroQuery.lastError().text();
        return Rc::ErrPrepareQuery;
    }
    heroQuery.bindValue(":profile_id", profileId);
    heroQuery.bindValue(":game_mode", gameMode);
    if (!heroQuery.exec()) {
        lwarn(op) << "hero sql exec error: " << heroQuery.lastError().text();
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
        lwarn(op) << "map sql prepare error: " << mapQuery.lastError().text();
        return Rc::ErrPrepareQuery;
    }
    mapQuery.bindValue(":profile_id", profileId);
    mapQuery.bindValue(":game_mode", gameMode);
    if (!mapQuery.exec()) {
        lwarn(op) << "map sql exec error: " << mapQuery.lastError().text();
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
        "AVG(CASE WHEN grp.team = gr.winning_team THEN ROUND(grp.hero_remaining_hp * 100.0 / h.hp, 1) END) "
        "FROM game_record_participants grp "
        "JOIN game_records gr ON gr.id = grp.game_id "
        "JOIN heroes h ON h.id = grp.hero_id "
        "WHERE grp.hero_id = :hero_id AND grp.profile_id = :profile_id "
        "AND gr.mode = :mode"
    )) {
        lwarn(op) << "statistic sql prepare error: " << query.lastError().text();
        return Rc::ErrPrepareQuery;
    }
    query.bindValue(":hero_id", id);
    query.bindValue(":profile_id", profileId);
    query.bindValue(":mode", gameMode);
    if (!query.exec()) {
        lwarn(op) << "hero found sql exec error: " << query.lastError().text();
        return Rc::ErrExecQuery;
    }
    if (query.next()) {
        stats.games = query.value(0).toULongLong();
        stats.wins = query.value(1).toULongLong();
        stats.averageWinningHp = query.value(2).toULongLong();
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
        lwarn(op) << "sql prepare error: " << query.lastError().text();
        return Rc::ErrPrepareQuery;
    }
    query.bindValue(":hero_id", id);
    query.bindValue(":profile_id", profileId);
    query.bindValue(":mode", gameMode);
    if (!query.exec()) {
        lwarn(op) << "hero found sql exec error: " << query.lastError().text();
        return Rc::ErrExecQuery;
    }
    if (query.next()) {
        stats.mostPlayedEnemyId = query.value(3).toULongLong();
    }

    return Rc::Ok;
}