import time
def check_time_to_now_even(seconds):
    """
    Checks whether time difference between now and given time in seconds is even
    """
    if seconds < 0:
        raise ValueError('received negative input')
   
    now=time.time()
    return (seconds-now)%2 == 0