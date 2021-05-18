const mysql = require('mysql2/promise');

const CONSTANTS = {
    UID: 1,
    host: 'localhost',
    user: 'api',
    password: 'musicapipassword',
    database: 'CSC315Final2021'
}


async function createConnection(){
    try {
        const { host, user, password, database } = CONSTANTS
        const connection = await mysql.createConnection({
            host,
            user,
            password,
            database
        });
        console.log(`connected as id ${connection.threadId}`);
        return connection;
    } catch (err) {
        console.error(err);
        process.exit(1);
    }
}

async function endConnection(conn){
    try {
        await conn.end();
        process.exit(0);
    } catch (err){
        console.error(err);
        process.exit(1);
    }
}


async function main(){
    const conn = await createConnection();
    const { UID } = CONSTANTS;

    async function getSubGenresRegion(){
        const query = "SELECT DISTINCT sg.sgname AS 'Sub Genres', r.rname AS 'Region' FROM Sub_Genre sg JOIN Band_Styles bs ON bs.sgname = sg.sgname JOIN Bands b ON b.bname = bs.bname JOIN Band_Origins bo ON bo.bname = b.bname JOIN Country c ON c.cname = bo.cname JOIN Region r ON r.rname = c.rname;"
        try { 
            const [rows] = await conn.execute(query);
            return rows;
        } catch (err) {
            console.error(err);
            return [];
        }
    }

    const subGenres = await getSubGenresRegion();
    console.log("Sub Genres and their Region\n");
    console.log(subGenres);

    // get bands currently not in the user's favorite but have the same sub_genres as their favorites
    async function getPotentialBands(userId) {
        const query = "SELECT DISTINCT b.bname AS 'Band' FROM Bands b JOIN Band_Styles bs ON bs.bname = b.bname WHERE b.bname NOT IN (SELECT b.bname FROM `User` u JOIN Favorites f ON u.uid = f.uid JOIN Bands b ON b.bid = f.band_id WHERE u.uid = ?) AND bs.sgname IN (SELECT bs.sgname FROM `User` u JOIN Favorites f ON u.uid = f.uid JOIN Bands b ON b.bid = f.band_id JOIN Band_Styles bs ON bs.bname = b.bname WHERE u.uid = ?);";
        try { 
            const [rows] = await conn.execute(query, [userId, userId]);
            return rows;
        } catch (err) {
            console.error(err);
            return [];
        }
    }

    console.log("\n\nOther bands with the same sub genres as user 1's favorites\n");
    const potentialBands = await getPotentialBands(UID);
    console.log(potentialBands)

    // get bands currently not in the user's favorite but have the same genres as their favorites
    async function getPotentialBandsBasedOnGenre(userId) {
        const query = "SELECT b.bname AS 'Band' FROM Bands b JOIN Band_Styles bs ON bs.bname = b.bname JOIN Sub_Genre sg ON sg.sgname = bs.sgname JOIN Genre g ON g.gname = sg.gname WHERE b.bname NOT IN (SELECT b.bname FROM `User` u JOIN Favorites f ON u.uid = f.uid JOIN Bands b ON b.bid = f.band_id WHERE u.uid = ?) AND g.gname IN (SELECT g.gname FROM `User` u JOIN Favorites f ON u.uid = f.uid  JOIN Bands b ON b.bid = f.band_id JOIN Band_Styles bs ON bs.bname = b.bname JOIN Sub_Genre sg ON sg.sgname = bs.sgname JOIN Genre g ON g.gname = sg.gname WHERE u.uid = ?);";
        try {
            const [rows] = await conn.execute(query, [userId, userId]);
            return rows;
        } catch (err) {
            console.error(err);
            return [];
        }
    }
    console.log("\n\nOther bands with the same genres as user 1's favorites\n");
    const potentialBandsGenres = await getPotentialBandsBasedOnGenre(UID);
    console.log(potentialBandsGenres)

    // get users who have the same favorites as you and list their other favorite bands
    async function getOtherUsersFavorites(userId){
        const query = "SELECT DISTINCT b.bname AS 'Band' FROM Bands b JOIN Favorites f ON f.band_id = b.bid JOIN `User` u ON u.uid = f.uid WHERE u.uid IN (SELECT u.uid FROM `User` u2 JOIN Favorites f2 ON f2.uid = u2.uid JOIN Bands b2 ON b2.bid = f2.band_id WHERE u2.uid != ? AND b2.bname IN (SELECT b2.bname FROM `User` u3 JOIN Favorites f3 ON f3.uid = u3.uid JOIN Bands b3 ON b3.bid = f3.band_id WHERE u3.uid = ?))  AND b.bname NOT IN (SELECT b4.bname FROM `User` u4 JOIN Favorites f4 ON f4.uid = u4.uid JOIN Bands b4 ON b4.bid = f4.band_id WHERE u4.uid = ?);";
        try {
            const [rows] = await conn.execute(query, [userId, userId, userId]);
            return rows;
        } catch (err) {
            console.error(err);
            return [];
        }
    }
    console.log("\n\nFinds other users who have the same band in their favorites, and list their other favorite bands.\n");
    const otherFavoriteBands = await getOtherUsersFavorites(UID);
    console.log(otherFavoriteBands);


    async function countriesToGo(userId){   
        const query = "SELECT DISTINCT c.cname FROM `User` u, Country c JOIN Band_Origins bo ON bo.cname = c.cname JOIN Bands b ON b.bname = bo.bname JOIN Band_Styles bs ON bs.bname = b.bname JOIN Sub_Genre sg ON sg.sgname = bs.sgname JOIN Genre g ON g.gname = sg.gname WHERE u.uid = ? AND c.cname != u.home_country AND g.gname IN (SELECT g2.gname FROM `User` u2 JOIN Favorites f ON f.uid = u2.uid JOIN Bands b2 ON b2.bid = f.band_id JOIN Band_Styles bs2 ON bs2.bname = b2.bname JOIN Sub_Genre sg2 ON sg2.sgname = bs2.sgname JOIN Genre g2 ON g2.gname = sg2.gname WHERE u2.uid = ?);";
        try {
            const [rows] = await conn.execute(query, [userId, userId]);
            return rows;
        } catch (err) {
            console.error(err);
            return [];
        }

    }
    console.log("\n\nList other countries, excluding the user’s home country, where they could travel to where they could hear the same genres as the bands in their favorites.\n");
    const countries = await countriesToGo(UID);
    console.log(countries);

    // Creates a new user
    async function insertUser(name, country){
        const query = "INSERT INTO `User` (name, home_country) VALUES (?, ?);";
        try { 
            const [row] = await conn.execute(query, [name, country]);
            console.log(`User Id: ${row.insertId}`);
            return row.insertId;
        } catch (err) {
            console.error(err);
            return err;
        }
    }

    // Add favorite band
    async function addFavoriteBand(userId, bandName){
        const bandExistQuery = "SELECT * FROM Bands b WHERE b.bname = ? LIMIT 1;";
        const addBandToFavoriteQuery = "INSERT INTO Favorites (uid, band_id) VALUES (?, ?);"
        try {
            // check if the band exists 
            const [rows] = await conn.execute(bandExistQuery, [bandName]);
            if(rows.length <= 0) throw new Error("Band does not exist"); // if it doesn't exist, throw an error
            // if it exists, create a favorite relationship that connects it to the user
            const band = rows[0];
            const [row] = await conn.execute(addBandToFavoriteQuery, [userId, band.bid]);
            console.log(`Favorite Id: ${row.insertId}`);
            return row.insertId;
        } catch (err) {
            console.error(err);
            return err;
        }
    }
    // await addFavoriteBand(1, "Death");

    // Delete a band from favorites;
    async function deleteBandFromFavorite(userId, bandName){
        const bandExistQuery = "SELECT * FROM Bands b WHERE b.bname = ? LIMIT 1;";
        const doesFavoriteExistQuery = "SELECT * FROM Favorites f WHERE f.uid = ? AND f.band_id = ? ;";
        const deleteFavoriteQuery = "DELETE FROM Favorites WHERE uid = ? AND band_id = ? ;";
        try {
            // check if the band exists 
            const [bands] = await conn.execute(bandExistQuery, [bandName]);
            if(bands.length <= 0) throw new Error("Band does not exist"); // if it doesn't exist, throw an error
            // if it exists, check if there's a favorite relationship between the user and the band
            const band = bands[0];
            const [favorites] = await conn.execute(doesFavoriteExistQuery [userId, band.bid]);
            if(favorites.length <= 0) throw new Error(`User does not have "${band.bname}" as a favorite band.`); // if there's no favorite relationship, throw an error
            // deleting favorite relationship
            await conn.execute(deleteFavoriteQuery, [userId, band.bid]);
        } catch (err) {
            console.error(err);
            return err;
        }
    }
    await endConnection(conn);
}

main();
