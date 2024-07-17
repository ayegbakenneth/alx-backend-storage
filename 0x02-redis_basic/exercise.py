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
    def get(self, key: str, fn: Callable = None) -> Union[str, bytes, int, float]:
        """ A method that takes a key argument and a callable argument """
        value = self._redis.get(key)
        if value is not None and fn is not None:
            return fn(value)
        return value

    def get_str(self, key: str) -> Union[str, bytes]:
        """ A method that get a value and convert it to str """
        return self.get(key, fn=lambda d: d.decode("utf-8"))

    def get_int(self, key: str) -> Union[int, bytes]:
        """ A method that get a value and convert it to int """
        return self.get(key, fn=int)
