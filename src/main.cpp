#include <irrlicht.h>

using namespace core;
using namespace scene;
using namespace video;
using namespace io;
using namespace gui;

int main()
{
   IrrlichtDevice *device =
      createDevice(EDT_SOFTWARE, dimension2d<u32>(640,480), 16
                 false, false, false, 0);
    if (!device)
        return 1;
}
