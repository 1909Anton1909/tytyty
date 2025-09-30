from Models.Base import *
from peewee import *


class Users(Base):
    id = PrimaryKeyField()
    login = CharField()
    name = CharField()
    password = CharField()
    role = CharField()


if __name__ == "__main__":
    pass

