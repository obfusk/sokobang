// Pov-ray image source for ksokoban
// copyright (c) 1998-1999  Anders Widell  <awl@hem.passagen.se>

#include "floor_common.inc"

object {
  intersection {
    plane {-z, 0.3 rotate < 30,    0, 0>}
    plane {-z, 0.3 rotate < 30,   60, 0>}
    plane {-z, 0.3 rotate < 30,  120, 0>} 
    plane {-z, 0.3 rotate < 30,  180, 0>}
    plane {-z, 0.3 rotate < 30,  240, 0>}
    plane {-z, 0.3 rotate < 30,  300, 0>}

    plane {-z, 0.3 rotate <-50,    0, 0>}
    plane {-z, 0.3 rotate <-50,   60, 0>}
    plane {-z, 0.3 rotate <-50,  120, 0>}
    plane {-z, 0.3 rotate <-50,  180, 0>}
    plane {-z, 0.3 rotate <-50,  240, 0>}
    plane {-z, 0.3 rotate <-50,  300, 0>}
  }

  finish {
    ambient 0.1
    diffuse 0.3
    reflection .25
    specular 1
    roughness 0.02
  }
  interior {
    ior 2.4
  }
  pigment { color rgbf <1, 0.1, 0.2, 0.8>}

  translate <0, -0.1, 0>
}
