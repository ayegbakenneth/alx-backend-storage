#!usr/bin/env python3
""" File executable path """


def list_all(mongo_collection):
    """ A function that lists all documents in a collection """

    mongo_list = []
    for collection in mongo_collection.find():
        mongo_list.append(collection)
    return mongo_list
