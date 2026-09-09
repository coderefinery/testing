def test_set_temp(monkeypatch):
    monkeypatch.setattr(reactor, "max_temperature", 100)
    assert check_reactor_temperature(99)  == 0
    assert check_reactor_temperature(100) == 0   # boundary cases easily go wrong
    assert check_reactor_temperature(101) == 1

def test_set_temp_alternative(monkeypatch):
    # No monkeypatching, but we need to access "reactor"
    from reactor import max_temperature
    assert check_reactor_temperature(max_temperature-1)  == 0
    assert check_reactor_temperature(max_temperature) == 0   # boundary cases easily go wrong
    assert check_reactor_temperature(max_temperature+1) == 1
