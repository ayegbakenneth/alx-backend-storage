#!/usr/bin/env python3
""" File executable path """
import redis
import uuid
from typing import Union
""" Module import path """

class Cache:
    def __init__(self):
        """ The constructor method """
        self._redis = redis.Redis()
        self._redis.flushdb()
    def store(self, data: Union[str, bytes, int, float]) -> str:
        """ A method that takes diferent types of data argument """
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

