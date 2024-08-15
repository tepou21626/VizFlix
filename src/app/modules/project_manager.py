import os

class ProjectManager():
    def __init__(self, project_dir) -> None:
        project_folders = [ f.path for f in os.scandir(project_dir) if f.is_dir() ]
        print(project_folders)