"""
Django settings for demo_project.

This settings file is enough to run the trifecta project tests, but as it
has no urls, middleware, templates etc. it won't function as a web project.

The purpose of this project is to prove that a Django application can run
and connect to the trifecta docker containers (postgres, redis, memcached
and elasticsearch.)

"""
import os
import urlparse

DEBUG = True

# required by Django
SECRET_KEY = 'trifecta'

# We install the auth app so that we get a model which we can use to
# force the creation of the test database, and run an effective test.
INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'test_app'
)

MIDDLEWARE_CLASSES = ()

ROOT_URLCONF = 'test_app.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'OPTIONS': {
            'loaders': (
                'django.template.loaders.filesystem.Loader',
                'django.template.loaders.app_directories.Loader'
            ),
        },
    },
]

# ================ trifecta services =========================
#
# This section will read configuration information in from
# environment variables, as if the application were running on Heroku

# read postgres config in from envvars
# see https://github.com/kennethreitz/dj-database-url
url = urlparse.urlparse(os.environ['DATABASE_URL'])
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': url.path[1:],
        'USER': url.username,
        'PASSWORD': url.password,
        'HOST': url.hostname,
        'PORT': url.port,
    }
}

# read memcache configuration in from env vars
# see https://github.com/rdegges/django-heroku-memcacheify
url = urlparse.urlparse(os.environ['MEMCACHE_URL'])
CACHES = {
    'default': {
        'BACKEND': 'django_pylibmc.memcached.PyLibMCCache',
        'BINARY': True,
        'LOCATION': '%s:%s' % (url.hostname, url.port),
        'OPTIONS': {
            'ketama': True,
            'tcp_nodelay': True
        },
        'TIMEOUT': 500
    }
}

# read redis configuration in from env vars
# see https://github.com/rdegges/django-heroku-memcacheify
url = urlparse.urlparse(os.environ['REDIS_URL'])
QUEUES = {
    'default': {
        'HOST': url.hostname,
        'PORT': url.port,
        'DB': 0,
        'PASSWORD': url.password,
    },
}

ELASTICSEARCH_URL = os.environ.get('ELASTICSEARCH_URL')
