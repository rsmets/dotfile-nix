{
  username = "rsmets";
  fullName = "Ray Smets";
  email = "rayjsmets@gmail.com";
  githubUsername = "rsmets";
  hostname = "rsmets-mbp";
  signingKey = ""; # Will be set up later if needed

  
  # Directory Configuration
  # These paths can be customized based on your preferences
  # All paths are relative to your home directory unless absolute paths are specified
  directories = {
    # Dotfiles repository location (relative to home directory)
    dotfiles = "Documents/dotfile";
    
    # Development workspace (where you keep your projects)
    # workspace = "dev";  # Uncomment and customize if needed
    
    # Additional custom directories for aliases and shortcuts
    # downloads = "Downloads";    # Default: Downloads
    # documents = "Documents";    # Default: Documents
    
    # Project-specific directories (examples)
    # Note: These are examples - uncomment and customize as needed
    personal = "dev/personal";
    work = "dev/work";
    opensource = "dev/open-source";
    sandbox = "dev/sandbox";
  };
  
  # Application Preferences (future extension point)
  # preferences = {
  #   # Terminal preferences
  #   terminal = {
  #     defaultSession = "main";
  #     theme = "gruvbox-dark";
  #   };
  #   
  #   # Development preferences
  #   development = {
  #     defaultEditor = "vim";
  #     defaultShell = "zsh";
  #   };
  # };
}
