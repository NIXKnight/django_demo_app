import random
from django.http import HttpResponse

leaky_list = []

def leaky_view(request):
    size = random.randint(10**6, 5 * 10**6)  # Random size between 1MB and 5MB
    leaky_list.append("x" * size)
    return HttpResponse(f"Leaked object of size {size}. Total leaked objects: {len(leaky_list)}")
