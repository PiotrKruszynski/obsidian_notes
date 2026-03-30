>[! Definition]
>**virtual machine (VM)** is an emulation of a computer system. It uses software instead of a physical computer to run programs and applications.

In general, VMs have the following characteristics:
- **Partitioning:** there might be several VMs on a single "host" and the resources of the physical system are divided between VMs.
- **Isolation:** a VM can be isolated from other VMs on the same physical machine in order to prevent any security issues and guarantee a high level of the utilization of resources.
- **Encapsulation:** in fact, VMs and their states are files saved on a host. Thus, they can be easily moved/copied (also to a different “host” machine) and checked by antimalware programs.

![[Pasted image 20260330114702.png]]

## Full Virtualization
- The guest OS is fully isolated by a VM from the virtualization layer and computer hardware.
- It uses binary translation and the direct approach as techniques for operations.
- It is considered to be less secure, slower, but more portable and compatible compared to paravirtualization.
## Paravirtualization
- The guest OS is only partially isolated by a VM from the virtualization layer and computer hardware.
- It uses the so called **hypercalls** – calls made by the operating system or by the process for a hypervisor when some services are required to be performed.
- It is considered to be more secure, faster, but less portable and compatible compared to full virtualization.