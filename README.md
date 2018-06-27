# GDC-DNA-Seq-pipeline-galaxy-wrapper
The GDC DNA-Seq analysis pipeline identifies somatic variants within whole exome sequencing (WXS) and whole genome sequencing (WGS) data. Somatic variants are identified by comparing allele frequencies in normal and tumor sample alignments, annotating each mutation, and aggregating mutations from multiple cases into one project file.

The first pipeline starts with a reference alignment step followed by co-cleaning to increase the alignment quality. Four different variant calling pipelines are then implemented separately to identify somatic mutations. Somatic-caller-identified variants are then annotated. An aggregation pipeline incorporates variants from all cases in one project into a MAF file for each pipeline.

DNA-Seq analysis is implemented across six main procedures:

   * Genome Alignment
   * Alignment Co-Cleaning
   * Somatic Variant Calling
   * Variant Annotation
   * Mutation Aggregation

**Genome Alignment**

Read groups are aligned to the reference genome BWA-MEM if mean read length is greater than or equal to 70 bp. Otherwise BWA-aln is used.
Each read group is aligned to the reference genome separately and all read group alignments that belong to a single aliquot are merged using SortSam and MergeSamFiles (Picard Tools).

**Co-cleaning Workflow**

Co-cleaning is performed as a separate pipeline as it uses multiple BAM files (i.e. the tumor BAM and normal tissue BAM) associated with the same patient. Both steps of this process are implemented using   GATK

	* Local realignment of insertions and deletions is performed using   IndelRealigner
	* A base quality score recalibration (BQSR) step is then performed using   BaseRecalibrator.
	* A filter reads step is preformed by Printreads

**Somatic Variant Calling** 

Aligned and co-cleaned BAM files are processed through the Somatic Mutation Calling Workflow as tumor-normal pairs.
Variant calling is performed using four separate pipelines:

	* MuSE
	* MuTect2
	* VarScan2
	* SomaticSniper

**Variant Call Annotation Workflow**

Raw VCF files are then annotated in the Somatic Annotation Workflow with the   Variant Effect Predictor v84
In addition to annotation False Positive Filter is used to label low quality variants in VarScan and SomaticSniper outputs.

**Somatic Agregation Workflow**

multiple vcf file can merged and using vcf2maf a MAF file from multiple vcf can be created.

**All the tools and option used in the command line pipeline can be used throught galaxy wrappers**
