import waterflow
import pytest


def test_water_column_height():
    assert waterflow.water_column_height(0.0,0.0) == pytest.approx(0.0)
    assert waterflow.water_column_height(0.0,10.0) == pytest.approx(7.5)
    assert waterflow.water_column_height(25.0,0.0) == pytest.approx(25.0)
    assert waterflow.water_column_height(48.3,12.8) == pytest.approx(57.9)

def test_pressure_gain_from_water_height():
    assert waterflow.pressure_gain_from_water_height(0)==pytest.approx(0,abs=0.001)
    assert waterflow.pressure_gain_from_water_height(30.2)==pytest.approx(295.628,abs=0.001)
    assert waterflow.pressure_gain_from_water_height(50.0)==pytest.approx(489.450,abs=0.001)

def test_pressure_loss_from_pipe():
    assert waterflow.pressure_loss_from_pipe(0.048692,0.00,0.018,1.75) == pytest.approx(0,abs=0.001)
    assert waterflow.pressure_loss_from_pipe(0.048692,200.00,0.000,1.75) == pytest.approx(0,abs=0.001)
    assert waterflow.pressure_loss_from_pipe(0.048692,200.00,0.018,0.00) == pytest.approx(0,abs=0.001)
    assert waterflow.pressure_loss_from_pipe(0.048692,200.00,0.018,1.75) == pytest.approx(-113.008,abs=0.001)
    assert waterflow.pressure_loss_from_pipe(0.048692,200.00,0.018,1.65) == pytest.approx(-100.462,abs=0.001)
    assert waterflow.pressure_loss_from_pipe(0.286870,1000.00,0.013,1.65) == pytest.approx(-61.576,abs=0.001)
    assert waterflow.pressure_loss_from_pipe(0.286870,1800.75,0.013,1.65) == pytest.approx(-110.884,abs=0.001)

pytest.main(["-v","--tb=long","-rN",__file__])