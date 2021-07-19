#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#ifdef __APPLE__
#include <OpenCL/opencl.h>
#else
#include <CL/cl.h>
#endif

#define MAX_SOURCE_SIZE (0x100000)

int main(void) {

int i;
const int LIST_SIZE = 6144;
double* a = (double*) malloc(sizeof(double) * LIST_SIZE);
for (int aaa = 0; aaa < LIST_SIZE; aaa++) {
	a[aaa] = 5.0;
}

double* b = (double*) malloc(sizeof(double) * LIST_SIZE);
for (int bbb = 0; bbb < LIST_SIZE; bbb++) {
	b[bbb] = 5.0;
}

double* c = (double*) malloc(sizeof(double) * LIST_SIZE);
for (int ccc = 0; ccc < LIST_SIZE; ccc++) {
	c[ccc] = 5.0;
}

double* d = (double*) malloc(sizeof(double) * LIST_SIZE);
for (int ddd = 0; ddd < LIST_SIZE; ddd++) {
	d[ddd] = 5.0;
}

double* e = (double*) malloc(sizeof(double) * LIST_SIZE);
for (int eee = 0; eee < LIST_SIZE; eee++) {
	e[eee] = 5.0;
}

double* f = (double*) malloc(sizeof(double) * LIST_SIZE);
for (int fff = 0; fff < LIST_SIZE; fff++) {
	f[fff] = 5.0;
}

cl_int g = 8;
cl_double h = 1.0;
FILE* fp;
char* source_str;
size_t source_size;

fp = fopen("npb-3.3-EP-embar.cl", "r");
if (!fp) {
fprintf(stderr, "Failed to load kernel.\n");
exit(1);
}
source_str = (char*)malloc(MAX_SOURCE_SIZE);
source_size = fread(source_str, 1, MAX_SOURCE_SIZE, fp);
fclose(fp);

cl_platform_id platform_id = NULL;
cl_device_id device_id = NULL;
cl_uint ret_num_devices;
cl_uint ret_num_platforms;
cl_int ret = clGetPlatformIDs(1, &platform_id, &ret_num_platforms);
ret = clGetDeviceIDs(platform_id, CL_DEVICE_TYPE_GPU, 1,
	&device_id, &ret_num_devices);
cl_context context = clCreateContext(NULL, 1, &device_id, NULL, NULL, &ret);

cl_command_queue command_queue = clCreateCommandQueue(context, device_id, 0, &ret);

cl_mem a_mem_obj = clCreateBuffer(context, CL_MEM_READ_WRITE,
	LIST_SIZE * sizeof(double), NULL, &ret);
cl_mem b_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY,
	LIST_SIZE * sizeof(double), NULL, &ret);
cl_mem c_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY,
	LIST_SIZE * sizeof(double), NULL, &ret);
cl_mem d_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY,
	LIST_SIZE * sizeof(double), NULL, &ret);
cl_mem e_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY,
	LIST_SIZE * sizeof(double), NULL, &ret);
cl_mem f_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY,
	LIST_SIZE * sizeof(double), NULL, &ret);
ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0,
	LIST_SIZE * sizeof(double), a, 0, NULL, NULL);
ret = clEnqueueWriteBuffer(command_queue, b_mem_obj, CL_TRUE, 0,
	LIST_SIZE * sizeof(double), b, 0, NULL, NULL);
ret = clEnqueueWriteBuffer(command_queue, c_mem_obj, CL_TRUE, 0,
	LIST_SIZE * sizeof(double), c, 0, NULL, NULL);
ret = clEnqueueWriteBuffer(command_queue, d_mem_obj, CL_TRUE, 0,
	LIST_SIZE * sizeof(double), d, 0, NULL, NULL);
ret = clEnqueueWriteBuffer(command_queue, e_mem_obj, CL_TRUE, 0,
	LIST_SIZE * sizeof(double), e, 0, NULL, NULL);
ret = clEnqueueWriteBuffer(command_queue, f_mem_obj, CL_TRUE, 0,
	LIST_SIZE * sizeof(double), f, 0, NULL, NULL);
cl_program program = clCreateProgramWithSource(context, 1,
	(const char**)&source_str, (const size_t*)&source_size, &ret);

ret = clBuildProgram(program, 1, &device_id, NULL, NULL, NULL);

cl_kernel kernel = clCreateKernel(program, "A", &ret);

ret = clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&a_mem_obj);
ret = clSetKernelArg(kernel, 1, sizeof(cl_mem), (void*)&b_mem_obj);
ret = clSetKernelArg(kernel, 2, sizeof(cl_mem), (void*)&c_mem_obj);
ret = clSetKernelArg(kernel, 3, sizeof(cl_mem), (void*)&d_mem_obj);
ret = clSetKernelArg(kernel, 4, sizeof(cl_mem), (void*)&e_mem_obj);
ret = clSetKernelArg(kernel, 5, sizeof(cl_mem), (void*)&f_mem_obj);
ret = clSetKernelArg(kernel, 6, sizeof(cl_int), &g);
ret = clSetKernelArg(kernel, 7, sizeof(cl_double), &h);
size_t global_item_size = LIST_SIZE;
size_t local_item_size = 64;

struct timeval t1, t2;
gettimeofday(&t1, NULL);
ret = clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL,
	&global_item_size, &local_item_size, 0, NULL, NULL);
ret = clFinish(command_queue);
gettimeofday(&t2, NULL);

double elapsedTime;
elapsedTime = (t2.tv_sec - t1.tv_sec) * 1000000.0;
elapsedTime += (t2.tv_usec - t1.tv_usec);

ret = clEnqueueReadBuffer(command_queue, a_mem_obj, CL_TRUE, 0,
	LIST_SIZE * sizeof(double), a, 0, NULL, NULL);
printf("%.4f", elapsedTime);

ret = clFlush(command_queue);
ret = clFinish(command_queue);
ret = clReleaseKernel(kernel);
ret = clReleaseProgram(program);
ret = clReleaseMemObject(a_mem_obj);
free(a);
ret = clReleaseMemObject(b_mem_obj);
free(b);
ret = clReleaseMemObject(c_mem_obj);
free(c);
ret = clReleaseMemObject(d_mem_obj);
free(d);
ret = clReleaseMemObject(e_mem_obj);
free(e);
ret = clReleaseMemObject(f_mem_obj);
free(f);
ret = clReleaseCommandQueue(command_queue);
ret = clReleaseContext(context);

return 0;

}
