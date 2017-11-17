# MatlabTimer
class for smart&amp;simple tic-toc measurements

Lukas Pospisil (USI Lugano)
published under MIT Licence, 2017

usage:
```
timers = Timers();
timers.start('my unique name');
   .. computation to be measured ..
timers.stop('my unique name');
timers.print();
```

see 'sample.m' for sample code
