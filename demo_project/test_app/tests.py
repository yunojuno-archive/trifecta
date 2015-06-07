#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Demo app tests."""
from django.conf import settings
from django.contrib.auth.models import User
from django.core.cache import cache
from django.test import TestCase

import redis
import requests


class TrifectaHealthTests(TestCase):

    """Sequence of tests to confirm that trifecta services are running."""

    def test_postgres_container(self):
        """Ping the postgres container."""
        self.assertEqual(User.objects.count(), 0)

    def test_memcached_container(self):
        """Ping the memcached container."""
        cache.set('ping', 'pong')
        self.assertEqual(cache.get('ping'), 'pong')

    def test_redis_container(self):
        """Ping the redis container."""
        r = redis.StrictRedis(host='localhost', port=6379, db=0)
        r.set('ping', 'pong')
        self.assertEqual(r.get('ping'), 'pong')

    def test_elasticsearch_container(self):
        """Ping the elasticsearch container."""
        url = settings.ELASTICSEARCH_URL
        self.assertEqual(requests.get(url).status_code, 200)
