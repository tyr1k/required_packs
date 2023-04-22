<!DOCTYPE html>
<html>
<body>
  <h1>Script to show required packages for a deb-pack</h1>
  <p>This script extracts the contents of a deb-pack and lists the required packages that need to be installed in order to run the executable files in the pack.</p>
  
  <h2>Usage</h2>
  <p>To use the script, provide the path to the deb-pack as an argument:</p>
  <pre>$ ./show_required_packages.sh path/to/deb-pack.deb</pre>
  
  <h2>Output</h2>
  <p>The script will output a list of packages that need to be installed to run the executable files in the deb-pack. If all required packages are already installed, the script will indicate this.</p>
  
  <h2>Optional: Print all pack-list in a file</h2>
  <p>The script can also generate a list of all packages required by the executable files in the deb-pack, and save it to a file. To do this, simply answer 'y' to the prompt when prompted:</p>
  <pre>Print all pack-list in file required_packs_for_[deb-pack]_[date]?(y/n)</pre>
  <p>A file named 'required_packs_for_[deb-pack]_[date]' will be created in the same directory as the script.</p>
</body>
</html>

