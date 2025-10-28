{{flutter_js}}
{{flutter_build_config}}

// See https://docs.flutter.dev/platform-integration/web/initialization

const loaderWrapper = document.getElementById('loader-wrapper');

function removeLoader() {
    if (loaderWrapper) {
        loaderWrapper.classList.add('hidden');
        setTimeout(() => {
            loaderWrapper.remove();
        }, 500);
    }
}

console.log('Loader: Starting Flutter loading process...');

_flutter.loader.load({
    onEntrypointLoaded: async function(engineInitializer) {
        try {
            const appRunner = await engineInitializer.initializeEngine();
            await appRunner.runApp();
            removeLoader();
            
        } catch (error) {
            console.error('Loader ERROR: Failed to run Flutter app:', error);
        }
    }
});