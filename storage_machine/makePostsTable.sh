IDIR=/eccs/users/lmgray16/cs488/postData/converted/

psql -d lmgray16_senior_project -U lmgray16 -c "DROP TABLE IF EXISTS posts;"
psql -d lmgray16_senior_project -U lmgray16 -c "CREATE TABLE posts(source TEXT, shared_from TEXT, date TIMESTAMP, text TEXT, reactions INT, likes INT, ahah INT, love INT, wow INT, sigh INT, grrr INT, comments INT, post_id BIGINT PRIMARY KEY, page_id TEXT, url TEXT);"

for file in $IDIR/*.csv
do
psql -d lmgray16_senior_project -U lmgray16 -c "\copy posts FROM '$file' DELIMITER ',' CSV HEADER;"
done

psql -d lmgray16_senior_project -U lmgray16 -c "ALTER TABLE posts ADD COLUMN entropy NUMERIC;"