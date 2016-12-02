function floor(number)
{
  return Math.floor(number*Math.pow(10,2))/Math.pow(10,2);
}

function dosum()
{
  var mi = document.temps.IR.value / 1200;
  var base = 1;
  var mbase = 1 + mi;
  for (i=0; i<document.temps.YR.value * 12; i++)
  {
    base = base * mbase
  }
  document.temps.PI.value = floor(document.temps.LA.value * mi / ( 1 - (1/base)))
  document.temps.MT.value = floor(document.temps.AT.value / 12)
  document.temps.MI.value = floor(document.temps.AI.value / 12)
  var dasum = document.temps.LA.value * mi / ( 1 - (1/base)) +
        document.temps.AT.value / 12 + 
        document.temps.AI.value / 12;
  document.temps.MP.value = floor(dasum);
}