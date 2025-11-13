"""Main app views"""

import socket
from django.shortcuts import render
from django.http import JsonResponse
from django.db import connection
from django.utils import timezone


# Create your views here.
def index(request):
    """Index view"""
    return render(request, "main/index.html")


def test_db(request):  # pylint: disable=unused-argument
    """Test db connection"""
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT 1;")
        return JsonResponse({"success": True})
    except Exception as e:  # pylint: disable=broad-except
        return JsonResponse({"success": False, "error": str(e)})


def server_info(request):  # pylint: disable=unused-argument
    """Server info view"""
    hostname = socket.gethostname()
    server_time = timezone.now().strftime("%Y-%m-%d %H:%M:%S %Z")
    return JsonResponse(
        {
            "hostname": hostname,
            "server_time": server_time,
        }
    )
