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

def test_pressure_loss_from_fittings():
    assert waterflow.pressure_loss_from_fittings(0,3) == pytest.approx(0,abs=0.001)
    assert waterflow.pressure_loss_from_fittings(1.65,0) == pytest.approx(0,abs=0.001)
    assert waterflow.pressure_loss_from_fittings(1.65,2) == pytest.approx(-0.109,abs=0.001)
    assert waterflow.pressure_loss_from_fittings(1.75,2) == pytest.approx(-0.122,abs=0.001)
    assert waterflow.pressure_loss_from_fittings(1.75,5) == pytest.approx(-0.306,abs=0.001)

def test_reynolds_number():
    assert waterflow.reynolds_number(0.048692,0.00) == pytest.approx(0,abs=1)
    assert waterflow.reynolds_number(0.048692,1.65) == pytest.approx(80069,abs=1)
    assert waterflow.reynolds_number(0.048692,1.75) == pytest.approx(84922,abs=1)
    assert waterflow.reynolds_number(0.286870,1.65) == pytest.approx(471729,abs=1)
    assert waterflow.reynolds_number(0.286870,1.75) == pytest.approx(500318,abs=1)

def test_pressure_loss_from_pipe_reduction():
    assert waterflow.pressure_loss_from_pipe_reduction(0.28687,0.00,1,0.048692) == pytest.approx(0,abs=0.001)
    assert waterflow.pressure_loss_from_pipe_reduction(0.28687,1.65,471729,0.048692) == pytest.approx(-163.744,abs=0.001)
    assert waterflow.pressure_loss_from_pipe_reduction(0.28687,1.75,500318,0.048692) == pytest.approx(-184.182,abs=0.001)


def test_kpa_to_psi():
    assert waterflow.kpa_to_psi(0)     == pytest.approx(0,    abs=0.0001)
    assert waterflow.kpa_to_psi(100)   == pytest.approx(14.5038, abs=0.0001)
    assert waterflow.kpa_to_psi(158.7) == pytest.approx(23.0175,  abs=0.0001)

pytest.main(["-v","--tb=long","-rN",__file__])