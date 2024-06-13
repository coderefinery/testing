def test_check_time(monkeypatch):
  def mocktime():
    return 2
  monkeypatch.setattr(time,"time",mocktime)
  assert check_time_to_now_even(0) == 1
  assert check_time_to_now_even(1) == 0