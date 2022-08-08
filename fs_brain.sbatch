#!/bin/bash
#SBATCH --job-name=freesurf
#SBATCH --account=camctrp
#SBATCH --qos=camctrp
#SBATCH --mem=10gb
#SBATCH --time=48:00:00
#SBATCH --output=job.%j.out

ml freesurfer/7.1.1
SUBJECTS_DIR=#SUBJECT DIRECTORY
SUBJECT=#SUBJECT NAME

# Perform Freesurfer Reconstruction
recon-all -s ${SUBJECT} -i $SUBJECTS_DIR/$SUBJECT.nii -all -nuintensitycor-3T -parallel

# Combine Left and Right Pial Surfaces
mris_convert --combinesurfs $SUBJECTS_DIR/${SUBJECT}/surf/rh.pial $SUBJECTS_DIR/${SUBJECT}/surf/lh.pial $SUBJECTS_DIR/${SUBJECT}/cortical.stl

# Get Subcortical Regions
mri_convert $SUBJECTS_DIR/${SUBJECT}/mri/aseg.mgz $SUBJECTS_DIR/${SUBJECT}/subcortical.nii

# Binarize Subcortical Regions
mri_binarize --i $SUBJECTS_DIR/${SUBJECT}/subcortical.nii --match 2 3 24 31 41 42 63 72 77 51 52 13 12 43 50 4 11 26 58 49 10 17 18 53 54 44 5 80 14 15 30 62 --inv --o $SUBJECTS_DIR/${SUBJECT}/bin.nii

# Combine Original Subcortical with Binary
fslmaths $SUBJECTS_DIR/${SUBJECT}/subcortical.nii -mul $SUBJECTS_DIR/${SUBJECT}/bin.nii $SUBJECTS_DIR/${SUBJECT}/subcortical.nii.gz

# Create TMP file
cp $SUBJECTS_DIR/${SUBJECT}/subcortical.nii.gz $SUBJECTS_DIR/${SUBJECT}/subcortical_tmp.nii.gz

# Unzip
gunzip -f $SUBJECTS_DIR/${SUBJECT}/subcortical_tmp.nii.gz

# Fill Holes in Volume
for i in 7 8 16 28 46 47 60 251 253 254 255; do
        mri_pretess $SUBJECTS_DIR/${SUBJECT}/subcortical_tmp.nii $i $SUBJECTS_DIR/${SUBJECT}/mri/norm.mgz $SUBJECTS_DIR/${SUBJECT}/subcortical_tmp.nii
done

# Binarize Volume
fslmaths $SUBJECTS_DIR/${SUBJECT}/subcortical_tmp.nii -bin $SUBJECTS_DIR/${SUBJECT}/subcortical_bin.nii

# Create Mesh
mri_tessellate $SUBJECTS_DIR/${SUBJECT}/subcortical_bin.nii.gz 1 $SUBJECTS_DIR/${SUBJECT}/subcortical

# Convert to stl
mris_convert $SUBJECTS_DIR/${SUBJECT}/subcortical $SUBJECTS_DIR/${SUBJECT}/subcortical.stl
