from .base import *

DATABASES = {
    'default': {
        'ENGINE': os.getenv('DJANGO_DATABASE_ENGINE', 'django.db.backends.mysql'),
        'NAME': os.getenv('DJANGO_DATABASE_NAME', 'django_demo_app'),
        'USER': os.getenv('DJANGO_DATABASE_USER', 'django_demo_app'),
        'PASSWORD': os.getenv('DJANGO_DATABASE_PASSWORD', 'django_demo_app'),
        'HOST': os.getenv('DJANGO_DATABASE_HOST', 'mariadb'),
        'PORT': os.getenv('DJANGO_DATABASE_PORT', '3306'),
    }
}
