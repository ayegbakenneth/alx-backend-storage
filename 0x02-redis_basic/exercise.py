#!/usr/bin/env python3
""" File executable path """
import redis
import uuid
from functools import wraps
from typing import Callable, Union
""" Module import path """

def call_history(method: Callable) -> Callable:
    """ A function that keeps history of methods call """
    @wraps(method)
    def wrapper(self, *args, **kwargs):
        key_in = method.__realname__ + ":inputs"
        key_out = method.__realname__ + ":outputs"
        self._redis.rpush(key_in, str(args))
        out = method(self, *args, **kwargs)
        self._redis.rpush(key_out, str(out))
        return output
    return wrapper

class Cache:
    def __init__(self):
        """ The constructor method """
        self._redis = redis.Redis()
        self._redis.flushdb()
    @call_history
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

    def replay(do: Callable):
        """ A replay function to display history of a function calls """
    key_in = do.__realame__ + ":inputs"
    key_out = do.__realname__ + ":outputs"
    inp = list(map(eval, cache._redis.lrange(key_in, 0, -1)))
    out = list(map(eval, cache._redis.lrange(key_out, 0, -1)))

    print(f"{func.__qualname__} was called {len(inputs)} times:")
    for ip, op in zip(inp, out):
        print(f"{func.__qualname__}{ip} -> {op}")
