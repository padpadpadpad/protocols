# DanPadLab protocols

## Outline

This is a collection of protocols useful we use for doing things in the DanPadLab. Some are lab-based and some are computational. The motivation is to try be as open as possible about the methods we use, and document them to make onboarding new lab members easier, while also making collaboration with other labs easier.

## Contributing

We would love for you to contribute to this repository! If you are a member of DanPadLab, you can come talk to me in person! If not, please open an issue [here](https://github.com/padpadpadpad/protocols/issues).

## How to use this repository

To use and contribute to this repository, you will need to use git and GitHub. A great resource to understand how to use GitHub and R is the [Happy Git and GitHub for the useR](https://happygitwithr.com/) book. It has not been completely updated for use with Positron, but the principles are mainly the same.

The protocols in this repository are written in [Quarto](https://quarto.org/), a publishing system that allows us to write documents in Markdown. They are then rendered into both html and pdf formats.

1. Clone the repository on GitHub into your own repositories.
2. Download the repository into your local computer.
3. [Positron](https://positron.posit.co/) is a great way to view the a GitHub repository and edit Quarto and R files. You can also use [RStudio](https://posit.co/download/rstudio-desktop/) if you prefer. Open the base folder (protocols) in Positron or RStudio.
4. If starting a new protocol, copy the `_protocol_template.qmd` file into `protocol_input` and rename it to the name of the protocol. If you are editing an existing protocol, you can skip this step.
5. Open the file you want to edit. Make changes. You can do this in a variety of ways.
    1. You can use Positron and RStudio to edit the .qmd files directly. They both have a built-in preview feature that allows you to see how the document will look when rendered.
    2. You can use [trackdown](https://github.com/claudiozandonella/trackdown/) which can allow you to create a copy of the .qmd file to Google Docs, allowing you to edit it there and then re-download it to your local computer, and re-rendering in quarto.
6. Render your changes using **quarto::quarto_render('protocol_input/file_name.qmd')**, or by clicking the "Render" button in Positron or RStudio. This will generate the HTML, PDF, and Word Document versions of the protocol. They will live in the **protocoloutput/file_name** folder.
7. Save and commit your changes. In both RStudio and Positron you can do this interactively in the IDE.
8. Push your changes to the your version of the repository.
9. Open a pull request on GitHub. This will allow us to review your changes and merge them into the main repository.
10. When we are happy with a protocol, we will move it to the **finished** folder, from where it will be copied to the DanPadLab website.

## An example of using trackdown

Install [**trackdown**](https://claudiozandonella.github.io/trackdown/) from GitHub.

```{r}
# install trackdown if you haven't already
if (!requireNamespace("trackdown", quietly = TRUE)) {
  remotes::install_github("ClaudioZandonella/trackdown")
}
```

Ask Dan Padfield for his Auth Token file that will allow **trackdown** to send and receive files from Google Drive.

We need to tell **trackdown** what our authentication token is.

```{r}
# set auth token
trackdown::trackdown_auth_configure(path = 'path/to/auth_token.json')
```

This command will take you to a webpage to authenticate the application. Click "Allow" to give the application permission to access your Google Drive.

Next we can send upload a file from this repository - a .qmd file - to Google Drive.

```{r}
# upload a file to Google Drive
trackdown::trackdown_upload(
  file = "protocol_input/ecoli_sampling.qmd"
)
```

We can then edit the file as a group in Google Docs. Once we are happy, we can download the file back to our local computer (and this repository).

```{r}
# download a file from Google Drive
trackdown::trackdown_download(
  file = "protocol_input/ecoli_sampling.qmd"
)
```

Finally, we can render the file using Quarto.

```{r}
quarto::quarto_render("protocol_input/ecoli_sampling.qmd")
```

This creates html and pdf version of the file in the `protocol_output` folder.
