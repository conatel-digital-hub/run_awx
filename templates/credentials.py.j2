DATABASES = {
    'default': {
        'ATOMIC_REQUESTS': True,
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': "{{ awx_database }}",
        'USER': "{{ awx_database_username }}",
        'PASSWORD': "{{ awx_database_password }}",
        'HOST': "{{ awx_database_host | default('postgres') }}",
        'PORT': "{{ awx_database_port | default(5432) }}",
    }
}

BROKER_URL = 'amqp://{}:{}@{}:{}/{}'.format(
    "{{ awx_rabbitmq_user }}",
    "{{ awx_rabbitmq_password }}",
    "{{ awx_rabbitmq_host | default('rabbitmq')}}",
    "{{ awx_rabbitmq_port }}",
    "{{ awx_rabbitmq_default_vhost }}")

CHANNEL_LAYERS = {
    'default': {'BACKEND': 'asgi_amqp.AMQPChannelLayer',
                'ROUTING': 'awx.main.routing.channel_routing',
                'CONFIG': {'url': BROKER_URL}}
}

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': '{}:{}'.format("{{ awx_memcached_host }}", "{{ awx_memcached_port }}")
    },
    'ephemeral': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
    },
}