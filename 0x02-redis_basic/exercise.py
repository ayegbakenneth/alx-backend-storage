#!/usr/bin/env python3
""" File executable path """
import redis
import uuid
from functools import wraps
from typing import Callable, Union
""" Module import path """

def count_calls(method: Callable) -> Callable:
    """ A method that counts number of times
    the class methods are called """

    @wraps(method)
    """ A wrapper method """
    def wrapper(self, *args, **kwargs):
        key = method.__qualname__
        self._redis.incr(key)
        return method(self, *args, **kwargs)
    return wrapper

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
