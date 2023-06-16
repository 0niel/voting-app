const String apiUrl = 'https://voting.mirea.ninja/api';
const String appwriteEndpoint = 'https://appwrite.mirea.ninja/v1';
const String appwriteProjectId = '63f74535e4d0790a5fac';

const String databaseId = '63f74b8d640effade5a3';

const String timersCollectionId = '6403486e078581b4a04e';
const String eventsCollectionId = '63fdfe6b9d7f2bedfcde';
const String pollsCollectionId = '63f751383945d22cf031';
const String votesCollectionId = '63f74ddbdcc5c832a40f';
const String resourcesCollectionId = '640f5fba811ffa978fc2';

/// Api key with access to get server time. Used to sinchronize client time with
/// server time to prevent time cheating in countdowns.
const String appwriteClientHealthApiKey =
    String.fromEnvironment('APPWRITE_CLIENT_HEALTH_API_KEY', defaultValue: "");
