#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Test app views."""

from django.shortcuts import render


def index(request):
    """Display the trifecta demo homepage."""
    return render(request, 'index.html')
