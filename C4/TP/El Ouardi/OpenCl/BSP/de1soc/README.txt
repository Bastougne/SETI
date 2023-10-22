note:before the below operations,make sure you have install the opencl SDK 14.0 and SoCEDS 14.0.
1. directly unzip the de1soc_openCL_bsp.zip into %ALTERAOCLSDKROOT%/board directory.
2. set the "User variables" AOCL_BOARD_PACKAGE_ROOT to %ALTERAOCLSDKROOT%/board/de1soc
3. open the windows command window and type "aoc --list-boards", it should output "de1soc_sharedonly"
4. dir to %ALTERAOCLSDKROOT%/board/de1soc/examples/hello_world
5. type "aoc device/hello_world.cl -o bin/hello_world.aocx --board de1soc_sharedonly" to generate the hardware configuration files
6. cd soceds commandline and dir to %ALTERAOCLSDKROOT%/board/de1soc/examples/hello_world/
7. type "make" to gernerate application on linux host
8. make the boot sd card for de1soc opencl, burn the de1soc_opencl_sd_card_image.img from the linux_sd_card_image.zip file(unzip it) into a 2G(class 10) at least micro SD card.
9. open the FAT partiation on a windows system,and replace the opencl.rbf with the %ALTERAOCLSDKROOT%/board/de1soc/examples/hello_world/bin_hello_world/top.rbf(aoc compiled output)
10.set the de1soc SW10 MSEL[4:0] to 01010 and boot the linux system with uart terminal with baudrate 115200
11.use ethernet port and scp command in the soceds command shell to send the %ALTERAOCLSDKROOT%/board/de1soc/examples/hello_world/bin/hello_world.aocx and %ALTERAOCLSDKROOT%/board/de1soc/examples/hello_world/hello_world to the linux /home/root directory.
12.after boot the SD card system. prepare to setup opencl env and dir into /home/root directory type "source ./init_opencl.sh"
13.type "aocl program /dev/acl0 hello_world.aocx" to configuate the FPGA with opencl hardware.
14.type "chmod +x hello"  and "./hello_world" to run the hello world opencl demo.you will see the result like this:



root@socfpga:~# ./hello_world
Querying platform for info:
==========================
CL_PLATFORM_NAME                         = Altera SDK for OpenCL
CL_PLATFORM_VENDOR                       = Altera Corporation
CL_PLATFORM_VERSION                      = OpenCL 1.0 Altera SDK for OpenCL, Version 14.0

Querying device for info:
========================
CL_DEVICE_NAME                           = de1soc_sharedonly : Cyclone V SoC Development Kit
CL_DEVICE_VENDOR                         = Altera Corporation
CL_DEVICE_VENDOR_ID                      = 4466
CL_DEVICE_VERSION                        = OpenCL 1.0 Altera SDK for OpenCL, Version 14.0
CL_DRIVER_VERSION                        = 14.0
CL_DEVICE_ADDRESS_BITS                   = 64
CL_DEVICE_AVAILABLE                      = true
CL_DEVICE_ENDIAN_LITTLE                  = true
CL_DEVICE_GLOBAL_MEM_CACHE_SIZE          = 32768
CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE      = 0
CL_DEVICE_GLOBAL_MEM_SIZE                = 536870912
CL_DEVICE_IMAGE_SUPPORT                  = false
CL_DEVICE_LOCAL_MEM_SIZE                 = 16384
CL_DEVICE_MAX_CLOCK_FREQUENCY            = 1000
CL_DEVICE_MAX_COMPUTE_UNITS              = 1
CL_DEVICE_MAX_CONSTANT_ARGS              = 8
CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE       = 134217728
CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS       = 3
CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS       = 8192
CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE       = 1024
CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR    = 4
CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT   = 2
CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT     = 1
CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG    = 1
CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT   = 1
CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE  = 0
Command queue out of order?              = false
Command queue profiling enabled?         = true
Using AOCX: hello_world.aocx

Kernel initialization is complete.
Launching the kernel...

Thread #2: Hello from Altera's OpenCL Compiler!

Kernel execution is complete.
