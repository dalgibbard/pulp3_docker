import random
chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*(-_=+)'
# Note; using end='' requires python3
print(''.join(random.choice(chars) for i in range(50)), end='', flush=True)
