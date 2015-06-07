#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""demo_project URL Configuration"""
from django.conf.urls import url

from test_app.views import index

urlpatterns = [
    url(r'^', index),
]
