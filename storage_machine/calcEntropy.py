from scipy.stats import entropy
import psycopg2
import psycopg2.extras

def main():
    database_conn, database_cur = connectToDatabase()
    data = fetchData(database_cur)
    entropy_values = calculateEntropy(data)
    insertData(database_conn, database_cur, entropy_values)
    disconnectFromDatabase(database_conn, database_cur)

def connectToDatabase():
    connectionString = "dbname='lmgray16_senior_project' user='lmgray16'"
    try:
        database_conn = psycopg2.connect(connectionString)
        database_cur = database_conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        return database_conn, database_cur
    except psycopg2.OperationalError:
        print("Connection Failed!")

def fetchData(database_cur):
    fetch_query = "select likes,ahah,love,wow,sigh,grrr,post_id from posts;"
    database_cur.execute(fetch_query)
    data = database_cur.fetchall()
    return data

def calculateEntropy(data):
    entropy_values = []
    for values in data:
        entropy = H(values[:-1])   # last value is postid
        post_id = values[-1]
        entropy_values.append((entropy, post_id))
    return entropy_values

def insertData(database_conn, database_cur, entropy_values):
    insert_query = "update posts set entropy=%s where post_id=%s;"
    database_cur.executemany(insert_query, entropy_values)
    database_conn.commit()

def disconnectFromDatabase(database_conn, database_cur):
    database_cur.close()
    database_conn.close()

def H(values):  # entropy function
    s = sum(values)
    if not s:
        return
    probvect = [x/s for x in values]    # compute probability vector
    h = entropy(probvect, base=2)       # compute entropy over prob vector
    return h



if __name__ == "__main__":
    main()

