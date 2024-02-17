from django.conf import settings
from django.urls import path
from django.http import HttpResponse
from django.core.management import execute_from_command_line

settings.configure(
    DEBUG=True,
    ROOT_URLCONF=__name__,
)

def hello_world(request):
    return HttpResponse("Hello, World! (django)")

urlpatterns = [
    path('', hello_world),
]

if __name__ == "__main__":
    execute_from_command_line(['manage.py', 'runserver', '8000'])
