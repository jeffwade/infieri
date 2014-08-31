#IN FIERI
Code base for my BFA capstone exhibit

##Definition
_in fieri_
: _L_. being in process of accomplishment, in progress, pending; beginning to have existence, not yet completely formed, becoming; to become, be made

##Project File Structure
+ `_support/` : partials and experimentation
  - `arduino/` : support files for arduino
  - `processing/` : support files for processing
+ `infierino/` : main arduino project folder
  + `infierino.ino` : main arduino code
+ `inprocess/` : main processing project folder
  + `inprocess.pde` : main processing code
    + `motionBlur.pde` : function for emulating motion blur
    + `readInputs.pde` : funtion for reading arduino inputs
    + `changeProperties.pde` : function containing interaction rules
  + `Shape.pde` : Shape class
    + `drawShape.pde` : function to draw shape according to number of sides


###Documentation
+ `README.md` : this document
+ `TASK-LIST.md` : current work plan
+ `TECH.md` : Technologies used