# 3D-Brain-Printing

*Requires Freesurfer and MeshLab

1. Run fs_brain.sbatch on HiperGator `sbatch fs_brain.sbatch`

2. Open cortical.stl and subcortical.stl in meshlab

3. Perform Filters -> Mesh Layers -> Flatten Visible Mesh Layers 

3. Perform Filters -> Smoothing, Fairing, and Deformantion -> ScaleDependent Laplacian Smoothing Filter
- Smoothing Steps = 100 
- Delta % = 0.1
- Affect only selected faces = FALSE

4. Perform Filters -> Remeshing, Simplification, and Reconstruction -> Simplification: Quadratic Edge Collapse Decimation

5. File -> Export Mesh
- Binary encoding = TRUE
