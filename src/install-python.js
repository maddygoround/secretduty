const path = require('path');
const core =  require('@actions/core');
const tc =  require('@actions/tool-cache');
const exec =  require('@actions/exec');
const {IS_WINDOWS, IS_LINUX, isGhes} =  require('./utils');
const TOKEN = core.getInput('token');
const AUTH = !TOKEN || isGhes() ? undefined : `token ${TOKEN}`;
const MANIFEST_REPO_OWNER = 'actions';
const MANIFEST_REPO_NAME = 'python-versions';
const MANIFEST_REPO_BRANCH = 'main';
const MANIFEST_URL = `https://raw.githubusercontent.com/${MANIFEST_REPO_OWNER}/${MANIFEST_REPO_NAME}/${MANIFEST_REPO_BRANCH}/versions-manifest.json`;

async function findReleaseFromManifest(
  semanticVersionSpec,
  architecture
) {
  const manifest = await tc.getManifestFromRepo(
    MANIFEST_REPO_OWNER,
    MANIFEST_REPO_NAME,
    AUTH,
    MANIFEST_REPO_BRANCH
  );
  return await tc.findFromManifest(
    semanticVersionSpec,
    false,
    manifest,
    architecture
  );
}

async function installPython(workingDirectory) {
  const options = {
    cwd: workingDirectory,
    env: {
      ...process.env,
      ...(IS_LINUX && {LD_LIBRARY_PATH: path.join(workingDirectory, 'lib')})
    },
    silent: true,
    listeners: {
      stdout: (data) => {
        core.info(data.toString().trim());
      },
      stderr: (data) => {
        core.error(data.toString().trim());
      }
    }
  };

  if (IS_WINDOWS) {
    await exec.exec('powershell', ['./setup.ps1'], options);
  } else {
    await exec.exec('bash', ['./setup.sh'], options);
  }
}

async function installCpythonFromRelease(release) {
  const downloadUrl = release.files[0].download_url;

  core.info(`Download from "${downloadUrl}"`);
  const pythonPath = await tc.downloadTool(downloadUrl, undefined, AUTH);
  core.info('Extract downloaded archive');
  let pythonExtractedFolder;
  if (IS_WINDOWS) {
    pythonExtractedFolder = await tc.extractZip(pythonPath);
  } else {
    pythonExtractedFolder = await tc.extractTar(pythonPath);
  }

  core.info('Execute installation script');
  await installPython(pythonExtractedFolder);
}

module.exports = {
  MANIFEST_URL,
  findReleaseFromManifest,
  installCpythonFromRelease,
};