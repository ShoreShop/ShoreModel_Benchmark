import matplotlib.pyplot as plt


def setup():
    plt.rcParams["font.size"] = "6"
    plt.rcParams["axes.grid"] = True
    plt.rcParams["grid.alpha"] = 0.3
    plt.rcParams["grid.color"] = "grey"
    plt.rcParams["grid.linestyle"] = "--"
    plt.rcParams["grid.linewidth"] = 0.5
    plt.rcParams["axes.grid"] = True

    #plt.rcParams["text.usetex"] = True
    plt.rcParams["font.family"] = "sans-serif"

# =============================================================================
#     plt.rcParams["text.latex.preamble"] = [
#         r"\usepackage{siunitx}",  # i need upright \micro symbols, but you need...
#         r"\sisetup{detect-all}",  # ...this to force siunitx to actually use your fonts
#         r"\usepackage[default]{sourcesanspro}",
#         r"\usepackage{amsmath}",
#         r"\usepackage{sansmath}",  # load up the sansmath so that math -> helvet
#         r"\sansmath",  # <- tricky! -- gotta actually tell tex to use!
   # ]
# =============================================================================
    
