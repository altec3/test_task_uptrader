from django.shortcuts import render


def base(request, name):
    return render(request, 'home.html', {'name': name})
