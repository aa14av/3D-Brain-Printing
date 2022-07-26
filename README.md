# 3D-Brain-Printing

*Requires Freesurfer and MeshLab

1. Run fs_brain.sbatch on HiperGator

2. Open cortical.stl and subcortical.stl in meshlab

3. Perform a Filters -> Smoothing, Fairing, and Deformantion -> ScaleDependent Laplacian Smoothing Filter
  *Smoothing Steps = 100
  *Delta abs = 0.02528 + Delta % = 0.1
  *Affect only selected faces = FALSE

4. Then

5. File -> Export Mesh
  *Binary encoding = TRUE
