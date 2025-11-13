"""Main app urls"""

from django.urls import path
from .views import index
from .views import test_db
from .views import server_info

urlpatterns = [
    path("", index),
    path("test-db", test_db, name="test_db"),
    path("server-info", server_info, name="server_info"),
]
