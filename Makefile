OUTPUT_DIR := ./build
TEX_OUTPUT_DIR := ./build/tex_output/
MD_FILE := GNS_Image_Backup_Restore_Instruction.md
MD_FILE_HTML := ~/share/GNS_Image_Backup_Restore_Instruction_HTML.md
MD_PDF := $(OUTPUT_DIR)/GNS_Image_Backup_Restore_Instruction.pdf
MD_TEX_PDF := $(TEX_OUTPUT_DIR)/GNS_Image_Backup_Restore_Instruction.pdf
TEX_FILE := $(OUTPUT_DIR)/GNS_Image_Backup_Restore_Instruction.tex
MD_TO_HTML := $(PWD)/scripts/md_image_to_html.py

all:$(MD_PDF) $(TEX_FILE) $(MD_TEX_PDF) $(MD_FILE_HTML)

$(MD_PDF): $(MD_FILE) ./pictures/auto-package-workflow.png ./pictures/backup-workflow.png ./pictures/googoltech-os-package-workflow.png
$(MD_FILE_HTML): $(MD_FILE)
	$(MD_TO_HTML) $< $@

$(TEX_FILE):$(MD_FILE)

$(OUTPUT_DIR)/%.pdf:%.md
	@mkdir -p $(OUTPUT_DIR)
	pandoc $< \
	--from markdown-implicit_figures \
	--resource-path=.:./pictures/ \
	--pdf-engine=xelatex \
	-V floatplacement=H \
	-V figurePosition=H \
	-V mainfont="Microsoft YaHei" \
	-V CJKmainfont="Noto Serif CJK SC" \
	-V fontsize=12pt \
	-V geometry:"a4paper, margin=2.5cm" \
	-o $@


$(OUTPUT_DIR)/%.tex:%.md
	@mkdir -p $(OUTPUT_DIR)
	pandoc $< -s  --pdf-engine=xelatex \
	-V CJKmainfont="Noto Serif CJK SC" \
	-o $(TEX_FILE)

$(TEX_OUTPUT_DIR)/%.pdf:$(OUTPUT_DIR)/%.tex
	@mkdir -p $(TEX_OUTPUT_DIR)
	xelatex -halt-on-error --output-directory=$(TEX_OUTPUT_DIR) $< 
	

.PHONEY:share clean clean_1 clean_2 clean_3

share:
	$(RM) ~/share/*.pdf
	@cp -fv $(MD_PDF) ~/share/
clean:
	$(RM) $(OUTPUT_DIR)/*.pdf
	$(RM) $(TEX_OUTPUT_DIR)/*.pdf
	$(RM) $(MD_FILE_HTML)

clean_1:
	$(RM) $(OUTPUT_DIR)/*.pdf
clean_2:
	$(RM) $(TEX_OUTPUT_DIR)/*.pdf
clean_3:
	$(RM) $(MD_FILE_HTML)

