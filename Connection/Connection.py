from peewee import *
#функция подключения к БД
def connect():
    mysql_db = MySQLDatabase('RobA1234_Tehnicuc',
                             user='RobA1234_Admin',
                             password='1234567',
                             host='10.11.13.118',
                             port=3306)
    return mysql_db

if __name__ == "__main__":
    print(connect().connect())