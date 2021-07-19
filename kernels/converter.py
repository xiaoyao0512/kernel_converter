import glob,os
import re
import subprocess as sp

def vecInit(fh, cl_argName, N, typ, number_list, C_or_OpenCL):
    assert len(number_list) > 0
    if (C_or_OpenCL == "C"):
        if (len(number_list) == 1):
            fh.write("{} {}[{}] = ".format(typ[:-1], cl_argName, N)+"{")
            for i in range(N-1):
                fh.write("{}, ".format(number_list[0]))
            fh.write("{}".format(number_list[0])+"};\n")
        else:
            fh.write("{} {}[{}] = ".format(typ[:-1], cl_argName, N) + "{\n")
            for i in range(N-1):
                fh.write("\t{")
                for idx in range(len(number_list)-1):
                    num = number_list[idx]
                    fh.write("{}, ".format(num))
                fh.write("{}".format(number_list[-1])+"},\n")
            fh.write("\t{")
            for idx in range(len(number_list)-1):
                num = number_list[idx]
                fh.write("{}, ".format(num))
            fh.write("{}".format(number_list[-1])+"}\n};\n\n")           
    else:
        if (len(number_list) == 1):
            fh.write("{} {} = ({}) malloc(sizeof({}) * LIST_SIZE);\n".format(typ, cl_argName, typ, typ[:-1]))
            fh.write("for (int {}{}{} = 0; {}{}{} < LIST_SIZE; {}{}{}++)".format(cl_argName, cl_argName, cl_argName, cl_argName, cl_argName, cl_argName, cl_argName, cl_argName, cl_argName) + " {\n")       
            fh.write("\t{}[{}{}{}] = {};\n".format(cl_argName, cl_argName, cl_argName, cl_argName, number_list[0]))
            fh.write("}\n\n")
        else:
            fh.write("{} {} = ({}) malloc(sizeof({}) * LIST_SIZE);\n".format(typ, cl_argName, typ, typ[:-1]))
            fh.write("for (int {}{}{} = 0; {}{}{} < LIST_SIZE; {}{}{}++)".format(cl_argName, cl_argName, cl_argName, cl_argName, cl_argName, cl_argName, cl_argName, cl_argName, cl_argName) + " {\n")       
            fh.write("\t{}[{}{}{}] = ({}) (".format(cl_argName, cl_argName, cl_argName, cl_argName, typ))
            for idx in range(len(number_list)-1):
                number = number_list[idx]
                fh.write(" {},".format(number))
            fh.write(" {}".format(number_list[-1]) + ");\n}\n\n")
            #fh.write(");\n\n")       


def scalarInit(fh, cl_argName, typ, number_list, C_or_OpenCL):
    assert len(number_list) > 0
    if (C_or_OpenCL == "C"):
        if (len(number_list) == 1):
            fh.write("{} {} = {};\n".format(typ, cl_argName, number_list[0]))
        else:
            fh.write("{} {} = ".format(typ, cl_argName) + "{ ")
            for idx in range(len(number_list)-1):
                number = number_list[idx]
                fh.write(" {},".format(number))
            fh.write(" {}".format(number_list[-1]) + "};\n")
    else:
        if (len(number_list) == 1):
            fh.write("cl_{} {} = {};\n".format(typ, cl_argName, number_list[0]))
        else:
            fh.write("{} {} = ".format(typ, cl_argName) + "({}) ( ".format(typ))
            for idx in range(len(number_list)-1):
                number = number_list[idx]
                fh.write(" {},".format(number))
            fh.write(" {}".format(number_list[-1]) + ");\n")
       

def varInitialization(fh, typ, cl_type, cl_argName, N):
    assert typ == "C" or typ == "OpenCL"
    if (cl_type == "int" or \
        cl_type == "char" or cl_type == "short" or cl_type == "long"):
        scalarInit(fh, cl_argName, cl_type, [8], typ)
    elif (cl_type == "double" or cl_type == "float"):
        scalarInit(fh, cl_argName, cl_type, [1.0], typ)
    elif (cl_type == "int*" or \
          cl_type == "char*" or cl_type == "short*" or cl_type == "long*"):
        vecInit(fh, cl_argName, N, cl_type, [5], typ)
    elif (cl_type == "double*" or cl_type == "float*"):
        vecInit(fh, cl_argName, N, cl_type, [5.0], typ)
    elif (cl_type == "float2*"):
        vecInit(fh, cl_argName, N, cl_type, [5.0, 5.0], typ)
    elif (cl_type == "int2"):
        scalarInit(fh, cl_argName, cl_type, [2, 2], typ)
    elif (cl_type == "float4*"):
        vecInit(fh, cl_argName, N, cl_type, [5.0, 5.0, 5.0, 5.0], typ)
    elif (cl_type == "char4*"):
        vecInit(fh, cl_argName, N, cl_type, [5, 5, 5, 5], typ)
    #elif (cl_type == ""):
    else:
        print "The current type \'{}\' is not supported.\n".format(cl_type)
        fh.close()
        exit(0)
    

def CHostCode(typ, platform, kernel_fname, filename, N, iterations, queue, argOrder):
    assert typ == "AMD" or typ == "NVD", "Please specify a correct type"
    assert platform == "CPU" or platform == "GPU", "Please specify a correct platform"
    assert N != 0 and iterations != 0
    assert iterations > N
    assert len(queue) != 0 and len(queue) == len(argOrder) 
    fname = filename+"_"+typ+"_main_"+platform+".c"
    fw = open(fname, 'w')
    fw.write("#include<stdio.h>\n")
    fw.write("#include<stdlib.h>\n")
    fw.write("#include<sys/time.h>\n")
    fw.write("#ifdef __APPLE__\n")
    fw.write("#include <OpenCL/opencl.h>\n")
    fw.write("#else\n")
    fw.write("#include <CL/cl.h>\n")
    fw.write("#endif\n\n")
    fw.write("#define MAX_SOURCE_SIZE (0x100000)\n\n")
    fw.write("int main(void) {\n\n")
    fw.write("int i;\n")
    fw.write("const int LIST_SIZE = {};\n".format(iterations))
    # The first argument is always the one that is being written
    # This does not need to be initialized    
    # Update v1: This is not true. Have updated it to be Read-writable
    var_type = queue[0]
    var_name = argOrder[0]
    varInitialization(fw, "OpenCL", var_type, var_name, N)
    for i in range(1, len(queue)):
        cl_type = queue[i]
        cl_argName = argOrder[i]
        #print "cl_type = -{}-, cl_argName = -{}-".format(cl_type, cl_argName)
        varInitialization(fw, "OpenCL", cl_type, cl_argName, N)
    # Initialization is done
    fw.write("FILE* fp;\n")
    fw.write("char* source_str;\n")
    fw.write("size_t source_size;\n\n")

    fw.write("fp = fopen(\"{}\", \"r\");\n".format(kernel_fname))
    fw.write("if (!fp) {\n")
    fw.write("fprintf(stderr, \"Failed to load kernel.\\n\");\n")
    fw.write("exit(1);\n")
    fw.write("}\n")
    fw.write("source_str = (char*)malloc(MAX_SOURCE_SIZE);\n")
    fw.write("source_size = fread(source_str, 1, MAX_SOURCE_SIZE, fp);\n")
    fw.write("fclose(fp);\n\n")
    fw.write("cl_platform_id platform_id = NULL;\n")
    fw.write("cl_device_id device_id = NULL;\n")
    fw.write("cl_uint ret_num_devices;\n")
    fw.write("cl_uint ret_num_platforms;\n")
    fw.write("cl_int ret = clGetPlatformIDs(1, &platform_id, &ret_num_platforms);\n")
    fw.write("ret = clGetDeviceIDs(platform_id, CL_DEVICE_TYPE_{}, 1,\n".format(platform))
    fw.write("\t&device_id, &ret_num_devices);\n")
    fw.write("cl_context context = clCreateContext(NULL, 1, &device_id, NULL, NULL, &ret);\n\n")
    fw.write("cl_command_queue command_queue = clCreateCommandQueue(context, device_id, 0, &ret);\n\n")
    fw.write("cl_mem {}_mem_obj = clCreateBuffer(context, CL_MEM_READ_WRITE,\n".format(var_name))
    fw.write("\tLIST_SIZE * sizeof({}), NULL, &ret);\n".format(var_type[:-1]))
    for i in range(1, len(queue)):
        cl_type = queue[i]
        cl_argName = argOrder[i]
        if (re.search(r'\*', cl_type)):
            fw.write("cl_mem {}_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY,\n".format(cl_argName))
            fw.write("\tLIST_SIZE * sizeof({}), NULL, &ret);\n".format(cl_type[:-1]))          
    for i in range(len(queue)):
        cl_type = queue[i]
        cl_argName = argOrder[i]
        if (re.search(r'\*', cl_type)):
            fw.write("ret = clEnqueueWriteBuffer(command_queue, {}_mem_obj, CL_TRUE, 0,\n".format(cl_argName))
            fw.write("\tLIST_SIZE * sizeof({}), {}, 0, NULL, NULL);\n".format(cl_type[:-1], cl_argName))
    fw.write("cl_program program = clCreateProgramWithSource(context, 1,\n")
    fw.write("\t(const char**)&source_str, (const size_t*)&source_size, &ret);\n\n")
    fw.write("ret = clBuildProgram(program, 1, &device_id, NULL, NULL, NULL);\n\n")
    fw.write("cl_kernel kernel = clCreateKernel(program, \"A\", &ret);\n\n")

    # Set the arguments of the kernel

    fw.write("ret = clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&{}_mem_obj);\n".format(var_name))
    for i in range(1, len(queue)):
        cl_type = queue[i]
        cl_argName = argOrder[i]
        argIdx = i
        if (re.search(r'\*', cl_type)):
            fw.write("ret = clSetKernelArg(kernel, {}, sizeof(cl_mem), (void*)&{}_mem_obj);\n".format(argIdx, cl_argName))
        else:
            fw.write("ret = clSetKernelArg(kernel, {}, sizeof(cl_{}), &{});\n".format(argIdx, cl_type, cl_argName))

    fw.write("size_t global_item_size = LIST_SIZE;\n")
    fw.write("size_t local_item_size = {};\n\n".format(N))

    fw.write("struct timeval t1, t2;\n")
    fw.write("gettimeofday(&t1, NULL);\n")
    fw.write("ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL,\n")
    fw.write("\t&global_item_size, &local_item_size, 0, NULL, NULL);\n")
    fw.write("ret = clFinish(command_queue);\n")
    fw.write("gettimeofday(&t2, NULL);\n\n")
    fw.write("double elapsedTime;\n")
    fw.write("elapsedTime = (t2.tv_sec - t1.tv_sec) * 1000000.0;\n")
    fw.write("elapsedTime += (t2.tv_usec - t1.tv_usec);\n\n")
    #fw.write("{} a = ({})malloc(sizeof({}) * LIST_SIZE);\n".format(var_type, var_type, var_type[:-1]))
    fw.write("ret = clEnqueueReadBuffer(command_queue, {}_mem_obj, CL_TRUE, 0,\n".format(var_name))
    fw.write("\tLIST_SIZE * sizeof({}), {}, 0, NULL, NULL);\n".format(var_type[:-1], var_name))
    fw.write("printf(\"%.4f\", elapsedTime);\n\n")

    fw.write("ret = clFlush(command_queue);\n")
    fw.write("ret = clFinish(command_queue);\n")
    fw.write("ret = clReleaseKernel(kernel);\n")
    fw.write("ret = clReleaseProgram(program);\n")

    fw.write("ret = clReleaseMemObject({}_mem_obj);\n".format(var_name))
    fw.write("free({});\n".format(var_name))
    for i in range(1, len(queue)):
        cl_type = queue[i]
        cl_argName = argOrder[i]
        if (re.search(r'\*', cl_type)):
            fw.write("ret = clReleaseMemObject({}_mem_obj);\n".format(cl_argName))
            fw.write("free({});\n".format(cl_argName))            
    fw.write("ret = clReleaseCommandQueue(command_queue);\n")
    fw.write("ret = clReleaseContext(context);\n\n")
    fw.write("return 0;\n\n")
    fw.write("}\n")

    fw.close()
    
    

files = glob.glob("*.cl")

files.sort(key=lambda f: os.stat(f).st_size)
fwriteAMD = open('prog_label_amd', 'w')
fwriteNVD = open('prog_label_nvd', 'w')

counter = 0

for clFile in files:
    print clFile
    if (counter < 0):
        counter += 1
        continue
    #os.system("gcc " + file + " -lm")
    #os.system("./a.out")
    fname = clFile[0:-3]
    filename = re.sub('\.', '_', fname)
    print filename 
    fr = open(clFile, 'r')
    fwC = open(filename+'.c', 'w')
    fwC.write("#include <stdio.h>\n\n")
    fwC.write("#include <stdbool.h>\n\n")
    fwC.write("#include <math.h>\n\n")
    fwC.write("#include \"type.h\"\n")
    #fw.write("void main() {\n")


    frAMD = open('cgo17-amd.csv', 'r')
    frNVD = open('cgo17-nvidia.csv', 'r')
    labelAMD = ''
    labelNVD = ''
    N = 0
    for line in frAMD:
        if (re.search(fname, line)):
            lst = line.split(',')
            labelAMD = lst[11]
            N = int(lst[10])
            if (N == 0):
                N = 256
            iterations = int(lst[9])
            print "N = ", N
            break
    frAMD.close()  

    for line in frNVD:
        if (re.search(fname, line)):
            lst = line.split(',')
            labelNVD = lst[11]
            N_nvd = int(lst[10])
            if (N == 0):
                N = 256
            iterations_nvd = int(lst[9])
            break
    frNVD.close()
    #fwriteAMD.write("{}\t{}\n".format(filename, labelAMD))
    #fwriteNVD.write("{}\t{}\n".format(filename, labelNVD))

    assert N != 0

    #fw.write("#include \"{}.h\"\n\n".format(filename))
    flag = False
    parenthesis = 0
    arguments = 1
    vectors = 0
    charType = False
    intType = False
    floatType = False
    doubleType = False
    queue = []
    # convert each OpenCL kernel to C style and write it to fwC
    var = ''
    varAssign = []
    for line in fr:
        #print "line: ", line
        if (re.match('__kernel', line)):
            flag = True
            line = re.sub('__kernel', '', line)
            line = re.sub('\(', '( ', line)
            line = re.sub('__constant', '', line)
            line = re.sub('(__)?global', '', line)
            line = re.sub('__local', '', line)
            line = re.sub('(__)?const ', '', line)
            line = re.sub('uint', 'int', line)
            #line = re.sub('float\d', 'float', line)
            #line = re.sub('int\d', 'int', line)
            line = re.sub('int4', 'int', line)
            line = re.sub('restrict', '', line)
            line = re.sub('uchar', 'char', line)
            line = re.sub('__read_only', '', line)
            #print line
            for i in range(len(line)):
                if (line[i] == '*'):
                    vectors += 1
                elif (line[i] == ','):
                    arguments += 1
            lst = line.split(' ')
            print "lst = ", lst
            for item in lst:
                if (
                    re.match('(u?)char.*\*?', item) or \
                    re.match('int.*\*?', item) or 
                    re.match('short.*\*?', item) or 
                    re.match('float.*\*?', item) or \
                    re.match('double.*\*?', item) or \
                    re.match('long.*\*?', item)
                   ):
                    queue.append(item)
            fwC.write(line)
            continue

        assert flag == True

        
        if (re.search(r'get\_global\_id', line)):
            #print "inside if "
            line = re.sub('const ', '', line)
            line = re.sub('unsigned ', '', line)
            lst = line.split(' ')
            var = lst[3]
            print "lst = ", lst
            #print var
            if (var != '='):
                cString = "for (int {} = 0; {} < {}; {}++)".format(var, var, N, var)+" {\n"
            else:
                var = lst[2]
                cString = "for ({} = 0; {} < {}; {}++)".format(var, var, N, var)+" {\n"
            parenthesis += 1
            #print cString
            fwC.write(cString)
            continue
        elif (re.search(r'get\_local\_id', line)):
            #print "inside if "
            
            if (var == ''):
                line = re.sub('const ', '', line)
                line = re.sub('unsigned ', '', line)
                lst = line.split(' ')
                var1 = lst[3]
                #print var
                cString = "for (int {} = 0; {} < {}; {}++)".format(var1, var1, N, var1)+" {\n"
                parenthesis += 1
                #print cString
                fwC.write(cString)
                continue
            else:
                #print "line = ", line
                line = re.sub(r'get\_local\_id\(\d+\)', "{}".format(var), line)
        elif (re.search(r'get\_group\_id', line)):
            #print "inside if "
            if (var == ''):
                line = re.sub('const ', '', line)
                line = re.sub('unsigned ', '', line)
                lst = line.split(' ')
                var = lst[3]
                #print var
                cString = "for (int {} = 0; {} < {}; {}++)".format(var, var, N, var)+" {\n"
                parenthesis += 1
                #print cString
                fwC.write(cString)
                continue
            else:
                line = re.sub(r'get\_group\_id\(\d+\)', "{}".format(var), line)            
        elif (re.search(r'\s+(?!//)barrier', line)):
            if (counter > 120):
                line = re.sub(r'barrier', "//barrier", line) 
                fwC.write(line)
            else:           
                parenthesis -= 1
                fwC.write("}\n")
                
                continue
            
            
        #assert var != ''
        #print "initial line = ", line
        line = re.sub('get\_global\_size\(\d+\)', "{}".format(N), line)
        line = re.sub('get\_local\_size\(\d+\)', "{}".format(int(N/16)), line)
        line = re.sub('__(global|local) ', '', line)
        line = re.sub('__clc_', '', line)
        line = re.sub('volatile', '', line)
        
        #line = re.sub('float\d', 'float', line)
        #line = re.sub('int\d', 'int', line)
        
        line = re.sub('const ', '', line)
        line = re.sub('unsigned ', '', line)
        line = re.sub('uint', 'int', line)
        line = re.sub('return', 'continue', line)
        line = re.sub('get\_num\_groups\(\d+\)', '1', line)
        line = re.sub(r'(0x)?[0-9a-fA-F]*U', "{}".format(N), line)

        # Insert some modulo operations at the right array index
        #print "line = ", line
        p = re.compile(r'.*[^for] (\w+) = .*[\*|+|^].*')
        result = p.findall(line)

        if (len(result) != 0):
            #print result[0]
            varAssign.append(result[0])
        #print "varAssign = ", varAssign

        # convert (float4)(x, x, x, x) to (float4){x, x, x, x}
        p = re.compile(r'\(float4\)\s*(\(.*\))')
        result = p.findall(line)
        if (len(result) != 0):    
            string = result[0]
            if (re.search(r',', string)):
                #print "string = ", string
                mod = re.sub(r'\(', '{', string)
                mod = re.sub(r'\)', '}', mod) 
                #print "mod = ", mod
                line = re.sub(r'\('+string+r'\)', mod, line)

        p = re.compile(r'\w+\[([^\[]*)\]')
        result = p.findall(line)
        #print "result = ", result
        #print "line = ", line
        #print "result = ", result
        #print "before for, line = ", line
        for i in result: 
            #print "i = ", i
            if (re.search(r'\d+', i)):
                #print "I am HERE1111111!!!!!!!!"
                p = re.compile(r'(\d+)')
                number = p.findall(line)
                #print "number = ", number
                num = int(number[0])
                if (num >= N and not i.isdigit()):
                    line = re.sub(r'\d+', "{}".format(int(N/16)), line)
                    i = re.sub(r'\d+', "{}".format(int(N/16)), i)
                    #print "modified i = ", i
                    #print "modified line = ", line
            #print "after if: i = ", i

            #if (((("+" in i) or ("-" in i)) and (("*" in i) or ("/" in i))) or i in varAssign):
            if ((("*" in i) or ("+" in i)) or i in varAssign):
                #print "I am HERE222222!!!!!!!!"
                line = re.sub(r'\['+re.escape(i)+r'\]', "[({})%{}]".format(i, N), line)
                #print "in second if, line = ", line
        #print "before writing, line = ", line
        fwC.write(line)

    fr.close()
    for i in range(parenthesis):
        fwC.write("}\n")

    # finished writing the kernel to fwC
    print "arguments = ", arguments
    print "vectors = ", vectors
    fwC.write("\n\n")
    # generate the main function
    # prepare the required arguments
    fwC.write("void main() {\n\n")
    argOrder = []
    start = ord('a')
    print "queue = ", queue
    
    queue_CHost = []
    argOrder_CHost = []
    while (len(queue) != 0):
        typ = queue.pop(0)
        queue_CHost.append(typ)
        argName = chr(start)
        argOrder.append(argName)
        argOrder_CHost.append(argName)
        varInitialization(fwC, "C", typ, argName, N)
        '''
        if (re.match('(u?)char.*\*', typ)):
            #argOrder.append(chr(start))
            fwC.write("char {}[{}] = ".format(chr(start), N)+"{")
            for i in range(N-1):
                fwC.write("{}, ".format(i))
            fwC.write("{}".format(N-1)+"};\n")
        elif (re.match('int.*\*', typ)):
            #argOrder.append(chr(start))
            fwC.write("int {}[{}] = ".format(chr(start), N)+"{")
            for i in range(N-1):
                fwC.write("{}, ".format(i))
            fwC.write("{}".format(N-1)+"};\n")
        elif (re.match('long.*\*', typ)):
            #argOrder.append(chr(start))
            fwC.write("long {}[{}] = ".format(chr(start), N)+"{")
            for i in range(N-1):
                fwC.write("{}, ".format(i))
            fwC.write("{}".format(N-1)+"};\n")
        elif (re.match('short.*\*', typ)):
            #argOrder.append(chr(start))
            fwC.write("short {}[{}] = ".format(chr(start), N)+"{")
            for i in range(N-1):
                fwC.write("{}, ".format(i))
            fwC.write("{}".format(N-1)+"};\n")
        elif (re.match('float.*\*', typ)):
            #argOrder.append(chr(start))
            fwC.write("float {}[{}] = ".format(chr(start), N)+"{")
            for i in range(N-1):
                fwC.write("{}, ".format(float(i)))
            fwC.write("{}".format(float(N-1))+"};\n")
        elif (re.match('double.*\*', typ)):
            #argOrder.append(chr(start))
            fwC.write("double {}[{}] = ".format(chr(start), N)+"{")
            for i in range(N-1):
                fwC.write("{}, ".format(float(i)))
            fwC.write("{}".format(float(N-1))+"};\n")
        elif (re.match('char.*', typ)):
            #argOrder.append(chr(start))
            fwC.write("char {} = 1;\n".format(chr(start)))
        elif (re.match('int.*', typ)):
            #argOrder.append(chr(start))
            fwC.write("int {} = 1;\n".format(chr(start)))
        elif (re.match('long.*', typ)):
            #argOrder.append(chr(start))
            fwC.write("long {} = 1;\n".format(chr(start)))
        elif (re.match('short.*', typ)):
            #argOrder.append(chr(start))
            fwC.write("short {} = 1;\n".format(chr(start)))
        elif (re.match('float.*', typ)):
            #argOrder.append(chr(start))
            fwC.write("float {} = 1.0;\n".format(chr(start)))
        elif (re.match('double.*', typ)):
            #argOrder.append(chr(start))
            fwC.write("double {} = 1.0;\n".format(chr(start)))
        '''
        start += 1
    
    assert len(argOrder) >= 1
    fwC.write("\nA (")
    while (len(argOrder) != 1):
        arg = argOrder.pop(0)
        fwC.write("{}, ".format(arg))
    arg = argOrder.pop(0)
    fwC.write("{}".format(arg)+");\n\n")   

    fwC.write("\n}\n")
    fwC.close()
    
    # Generate C host code for each kernel
    #print "queue_CHost = ", queue_CHost
    #print "argOrder_CHost = ", argOrder_CHost
    CHostCode("AMD", "CPU", clFile, filename, N, iterations, queue_CHost, argOrder_CHost)
    CHostCode("AMD", "GPU", clFile, filename, N, iterations, queue_CHost, argOrder_CHost)
    '''
    fname = filename+"_"+"AMD"+"_main_"+"CPU"+".c"
    #print fname
    ret = os.system("gcc {} -l OpenCL -std=c99".format(fname))
    if (ret != 0):
        print "{}: Something wrong with COMPILATION! Exit the program!".format(fname)
        fwriteAMD.close() 
        fwriteNVD.close()
        exit(0)
    result = sp.check_output(['./a.out'])
    execT_AMD_CPU = float(result)
    fname = filename+"_"+"AMD"+"_main_"+"GPU"+".c"
    ret = os.system("g++ -I /usr/local/cuda-9.0/include {} -l OpenCL -std=c99".format(fname))
    if (ret != 0):
        print "{}: Something wrong with COMPILATION! Exit the program!".format(fname)
        fwriteAMD.close() 
        fwriteNVD.close()
        exit(0)
    result = sp.check_output(['./a.out'])
    execT_AMD_GPU = float(result)
    if (execT_AMD_CPU > execT_AMD_GPU):
        labelAMD = "CPU"
    else:
        labelAMD = "GPU"
    fwriteAMD.write("{}\t{}\n".format(filename, labelAMD))


    CHostCode("NVD", "CPU", clFile, filename, N, iterations, queue_CHost, argOrder_CHost)
    CHostCode("NVD", "GPU", clFile, filename, N, iterations, queue_CHost, argOrder_CHost)
    fname = filename+"_"+"NVD"+"_main_"+"CPU"+".c"
    #print fname
    ret = os.system("gcc {} -l OpenCL -std=c99".format(fname))
    if (ret != 0):
        print "{}: Something wrong with COMPILATION! Exit the program!".format(fname)
        fwriteAMD.close() 
        fwriteNVD.close()
        exit(0)
    result = sp.check_output(['./a.out'])
    execT_NVD_CPU = float(result)
    fname = filename+"_"+"NVD"+"_main_"+"GPU"+".c"
    ret = os.system("g++ -I /usr/local/cuda-9.0/include {} -l OpenCL -std=c99".format(fname))
    if (ret != 0):
        print "{}: Something wrong with COMPILATION! Exit the program!".format(fname)
        fwriteAMD.close() 
        fwriteNVD.close()
        exit(0)
    result = sp.check_output(['./a.out'])
    execT_NVD_GPU = float(result)
    if (execT_NVD_CPU > execT_NVD_GPU):
        labelNVD = "CPU"
    else:
        labelNVD = "GPU"
    fwriteNVD.write("{}\t{}\n".format(filename, labelNVD))
    '''

# It seems that         
# filename == "parboil-0_2-sad-larger_sad_calc_16" or \
# filename == "amd-app-sdk-3_0-MatrixTranspose-matrixTranspose" # errors?
# parboil-0_2-sad-larger_sad_calc_8
# have errors?

# function calls:
# rodinia-3_1-particlefilter-likelihood_kernel
# npb-3_3-MG-kernel_zran3_2
# npb-3_3-BT-z_solve.c
# npb-3_3-BT-y_solve.c
# npb-3_3-BT-x_solve.c
# rodinia-3_1-nw-nw_kernel2
# rodinia-3_1-nw-nw_kernel1
# shoc-1_1_5-Stencil2D-StencilKernel
# npb-3_3-EP-embar
# shoc-1_1_5-Sort-bottom_scan
# shoc-1_1_5-Sort-top_scan.
# rodinia-3_1-cfd-compute_step_factor
# npb-3_3-LU-setbv1
# npb-3_3-FT-cffts1
# npb-3_3-FT-cffts2
# npb-3_3-FT-cffts3
# rodinia-3_1-particlefilter-normalize_weights_kernel
#        filename == "npb-3_3-BT-initialize5" or \
#        filename == "npb-3_3-BT-initialize4" or \
#        filename == "npb-3_3-BT-initialize3" or \
#        filename == "npb-3_3-SP-initialize5" or \
#        filename == "npb-3_3-SP-initialize4" or \
#        filename == "npb-3_3-SP-initialize3" or \
# amd-app-sdk-3_0-BlackScholes-blackScholes
# shoc-1_1_5-Scan-bottom_scan.c
# rodinia-3_1-particlefilter-likelihood_kernel
# rodinia-3_1-nw-nw_kernel2


#npb-3_3-BT-exact_rhs1
#         filename == "npb-3_3-SP-exact_rhs1" or \
#        filename == "npb-3_3-BT-initialize1" or \
# npb-3_3-SP-compute_rhs6
# npb-3_3-SP-exact_rhs5
# npb-3_3-LU-ssor2
# npb-3_3-SP-initialize1
# parboil-0_2-stencil-naive_kernel
# npb-3_3-BT-compute_rhs2
# npb-3_3-SP-compute_rhs2
# npb-3_3-SP-add
# npb-3_3-BT-z_solve2
# npb-3_3-BT-x_solve2
# npb-3_3-BT-y_solve2
# npb-3_3-BT-add
# npb-3_3-LU-ssor3





# no "mad" in amd-app-sdk-3_0-SimpleConvolution-simpleSeparableConvolutionPass(1/2)
# no convert_float4 in amd-app-sdk-3_0-SobelFilter-sobel_filter
# no atom_xchg atomic_add/min in parboil-0_2-bfs-BFS_kernel
# parboil-0_2-sad-mb_sad_calc
# nvidia-4_2-FDTD3d-FiniteDifferences

# intersting kernel: shoc-1_1_5-FFT-chk1D_512

# stop at counter 188
    if ( 
        filename == "nvidia-4_2-MersenneTwister-BoxMuller" or \
        filename == "shoc-1_1_5-Scan-top_scan" or \
        filename == "npb-3_3-FT-compute_initial_conditions" or \
        filename == "shoc-1_1_5-Stencil2D-CopyRect" or \
        filename == "npb-3_3-MG-kernel_zran3_1" or \
        filename == "npb-3_3-BT-exact_rhs1" or \
        filename == "npb-3_3-SP-exact_rhs1" or \
        filename == "npb-3_3-BT-initialize1" or \
        filename == "shoc-1_1_5-FFT-chk1D_512" or \
        filename == "npb-3_3-LU-setbv3" or \
        filename == "npb-3_3-LU-setbv2" or \
        filename == "npb-3_3-SP-compute_rhs6" or \
        filename == "amd-app-sdk-3_0-SimpleConvolution-simpleSeparableConvolutionPass2" or \
        filename == "amd-app-sdk-3_0-SimpleConvolution-simpleSeparableConvolutionPass1" or \
        filename == "npb-3_3-SP-exact_rhs5" or \
        filename == "npb-3_3-BT-exact_rhs5" or \
        filename == "npb-3_3-BT-compute_rhs6" or \
        filename == "npb-3_3-LU-ssor2" or \
        filename == "shoc-1_1_5-Sort-top_scan" or \
        filename == "npb-3_3-SP-initialize1" or \
        filename == "rodinia-3_1-cfd-compute_step_factor" or \
        filename == "npb-3_3-LU-setbv1" or \
        filename == "npb-3_3-FT-cffts1" or \
        filename == "npb-3_3-FT-cffts2" or \
        filename == "npb-3_3-FT-cffts3" or \
        filename == "rodinia-3_1-particlefilter-normalize_weights_kernel" or \
        filename == "parboil-0_2-stencil-naive_kernel" or \
        filename == "npb-3_3-BT-compute_rhs2" or \
        filename == "npb-3_3-SP-compute_rhs2" or \
        filename == "npb-3_3-SP-add" or \
        filename == "npb-3_3-BT-z_solve2" or \
        filename == "npb-3_3-BT-x_solve2" or \
        filename == "npb-3_3-BT-y_solve2" or \
        filename == "npb-3_3-BT-add" or \
        filename == "npb-3_3-LU-ssor3" or \
        filename == "npb-3_3-BT-initialize5" or \
        filename == "npb-3_3-BT-initialize4" or \
        filename == "npb-3_3-BT-initialize3" or \
        filename == "npb-3_3-SP-initialize5" or \
        filename == "npb-3_3-SP-initialize4" or \
        filename == "npb-3_3-SP-initialize3" or \
        "npb-3_3" in filename or \
        filename == "amd-app-sdk-3_0-BlackScholes-blackScholes" or \
        filename == "shoc-1_1_5-MD5Hash-FindKeyWithDigest_Kernel" or \
        filename == "amd-app-sdk-3_0-SobelFilter-sobel_filter" or \
        filename == "parboil-0_2-sad-larger_sad_calc_16" or \
        filename == "parboil-0_2-bfs-BFS_kernel" or \
        filename == "shoc-1_1_5-Scan-bottom_scan" or \
        filename == "parboil-0_2-sad-mb_sad_calc" or \
        filename == "parboil-0_2-sad-larger_sad_calc_8" or \
        filename == "rodinia-3_1-particlefilter-likelihood_kernel" or \
        filename == "rodinia-3_1-nw-nw_kernel2" or \
        filename == "rodinia-3_1-nw-nw_kernel1" or \
        filename == "shoc-1_1_5-Stencil2D-StencilKernel" or \
        filename == "nvidia-4_2-FDTD3d-FiniteDifferences"
       ): 
        counter += 1
        continue        
    '''
    if (filename == "nvidia-4_2-MersenneTwister-BoxMuller" or \ 
        filename == "shoc-1_1_5-Scan-top_scan" or \ 
        filename == "polybench-gpu-1_0-gramschmidt-gramschmidt_kernel2" or \
        filename == "rodinia-3_1-cfd-initialize_variables" or \
        filename == "rodinia-3_1-nn-NearestNeighbor" or \
        filename == "npb-3_3-FT-compute_initial_conditions" or \
        filename == "shoc-1_1_5-Stencil2D-CopyRect" or \
        filename == "npb-3_3-MG-kernel_zran3_1" or \
        filename == "shoc-1_1_5-FFT-chk1D_512" or \
        filename == "npb-3_3-LU-setbv2" or \
        filename == "npb-3_3-LU-setbv3" or \
        filename == "amd-app-sdk-3_0-SimpleConvolution-simpleSeparableConvolutionPass2" or \
        filename == "amd-app-sdk-3_0-SimpleConvolution-simpleSeparableConvolutionPass1" or \
        filename == "rodinia-3_1-cfd-compute_step_factor" or \
        filename == "npb-3_3-LU-setbv1" or \
        filename == "npb-3_3-FT-cffts1" or \
        filename == "npb-3_3-FT-cffts2" or \
        filename == "npb-3_3-FT-cffts3" or \
        filename == "shoc-1_1_5-Sort-top_scan" or \
        filename == "rodinia-3_1-particlefilter-normalize_weights_kernel" or \
        filename == "amd-app-sdk-3_0-SimpleConvolution-simpleNonSeparableConvolution" or \
        filename == "npb-3_3-BT-initialize5" or \
        filename == "npb-3_3-BT-initialize4" or \
        filename == "npb-3_3-BT-initialize3" or \
        filename == "npb-3_3-SP-initialize5" or \
        filename == "npb-3_3-SP-initialize4" or \
        filename == "npb-3_3-SP-initialize3" or \
        filename == "amd-app-sdk-3_0-BlackScholes-blackScholes" or \
        filename == "npb-3_3-CG-makea_0" or \
        filename == "shoc-1_1_5-MD5Hash-FindKeyWithDigest_Kernel" or \
        filename == "amd-app-sdk-3_0-SobelFilter-sobel_filter" or \
        filename == "parboil-0_2-sad-larger_sad_calc_16" or \
        filename == "amd-app-sdk-3_0-MatrixTranspose-matrixTranspose" or \
        filename == "npb-3_3-LU-setiv" or \
        filename == "npb-3_3-LU-error" or \
        filename == "parboil-0_2-bfs-BFS_kernel" or \
        filename == "npb-3_3-BT-initialize2" or \
        filename == "npb-3_3-SP-initialize2" or \
        filename == "parboil-0_2-sad-mb_sad_calc" or \
        filename == "shoc-1_1_5-Scan-bottom_scan" or \
        filename == "parboil-0_2-sad-larger_sad_calc_8" or \
        filename == "rodinia-3_1-particlefilter-likelihood_kernel" or \
        filename == "npb-3_3-MG-kernel_zran3_2" or \
        filename == "npb-3_3-BT-z_solve" or \
        filename == "npb-3_3-BT-y_solve" or \
        filename == "npb-3_3-BT-x_solve" or \
        filename == "rodinia-3_1-nw-nw_kernel2" or \
        filename == "rodinia-3_1-nw-nw_kernel1" or \
        filename == "shoc-1_1_5-Stencil2D-StencilKernel" or \
        filename == "npb-3_3-EP-embar" or \
        filename == "shoc-1_1_5-Sort-bottom_scan" or \
        filename == "amd-app-sdk-3_0-MatrixMultiplication-mmmKernel"
        
       ):
        counter += 1
        continue
    '''
    os.system("chmod 777 {}.c".format(filename))
    ret = os.system("gcc {}.c -lm -std=c99".format(filename))
    if (ret != 0):
        print "Something wrong with COMPILATION! Exit the program!"
        print "counter = ", counter
        fwriteAMD.close() 
        fwriteNVD.close()
        exit(0)
    else:
        print "{}: Compilation is successful. Move to execution.".format(filename)
    ret = os.system("./a.out")
    if (ret != 0):
        print "{}: Something wrong with RUNTIME! Exit the program!".format(filename)
        print "counter = ", counter
        fwriteAMD.close() 
        fwriteNVD.close()
        exit(0)
    else:
        print "{}: Execution is successful. Move to next file.".format(filename)

    counter += 1
    if (counter == 1):
        break

fwriteAMD.close() 
fwriteNVD.close()

