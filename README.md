# 3D-Brain-Printing

*Requires Freesurfer and MeshLab

Run fs_brain.sbatch on HiperGator

Now, open cortical.stl and subcortical.stl in meshlab
Perform a Filters -> Smoothing, Fairing, and Deformantion -> ScaleDependent Laplacian Smoothing Filter
Smoothing Steps = 100
Delta abs = 0.02528 + Delta % = 0.1
Affect only selected faces = FALSE

Then

Then File -> Export Mesh
Binary encoding = TRUE
