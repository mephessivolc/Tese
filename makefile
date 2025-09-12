# Nome do arquivo principal
MAIN = main.tex
PDF  = 682bbf49c7c58db96ed58bbd/main.pdf
WORKDIR = 682bbf49c7c58db96ed58bbd

# ========================
# LaTeX
# ========================

build:
	docker compose run --rm latex latexmk -pdf $(MAIN)

view:
	xdg-open $(PDF)

all: build view

clean:
	docker compose run --rm latex bash -c "\
	find . -type f \( \
		-name '*.aux' -o \
		-name '*.bbl' -o \
		-name '*.blg' -o \
		-name '*.brf' -o \
		-name '*.idx' -o \
		-name '*.ilg' -o \
		-name '*.ind' -o \
		-name '*.lof' -o \
		-name '*.log' -o \
		-name '*.lot' -o \
		-name '*.out' -o \
		-name '*.toc' -o \
		-name '*.synctex.gz' -o \
		-name '*.synctex(busy)' -o \
		-name '*.fdb_latexmk' -o \
		-name '*.fls' -o \
		-name '*.nav' -o \
		-name '*.snm' -o \
		-name '*.vrb' -o \
		-name '*.xdv' -o \
		-name '*.bcf' -o \
		-name '*.run.xml' \
	\) -print -delete"

clean_pdf:
	docker compose run --rm latex bash -c "\
	find . -type f \( \
		-name '*.aux' -o \
		-name '*.bbl' -o \
		-name '*.blg' -o \
		-name '*.brf' -o \
		-name '*.idx' -o \
		-name '*.ilg' -o \
		-name '*.ind' -o \
		-name '*.lof' -o \
		-name '*.log' -o \
		-name '*.lot' -o \
		-name '*.out' -o \
		-name '*.toc' -o \
		-name '*.synctex.gz' -o \
		-name '*.synctex(busy)' -o \
		-name '*.fdb_latexmk' -o \
		-name '*.fls' -o \
		-name '*.nav' -o \
		-name '*.snm' -o \
		-name '*.vrb' -o \
		-name '*.xdv' -o \
		-name '*.bcf' -o \
		-name '*.pdf' -o \
		-name '*.run.xml' \
	\) -print -delete"


# ========================
# GitHub (raiz)
# ========================

push_github:
	git add .
	git commit -m "update: $(shell date +'%Y-%m-%d %H:%M:%S')" || true
	git push origin main

# ========================
# Overleaf (apenas LaTeX)
# ========================

push_overleaf:
	cd $(WORKDIR) && git add .
	cd $(WORKDIR) && git commit -m "update: $(shell date +'%Y-%m-%d %H:%M:%S')" || true
	cd $(WORKDIR) && git push origin master

pull_overleaf:
	cd $(WORKDIR) && git pull origin master


# =======================
# Deploy Github
# =======================

deploy_github: build clean push_github

# =======================
# Deploy Overleaf
# =======================

deploy_overleaf: build clean_pdf push_overleaf

# =======================
# Deploy All
# =======================

deploy_all: build clean_pdf push_github push_overleaf