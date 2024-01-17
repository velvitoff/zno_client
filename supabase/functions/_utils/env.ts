export class Env {
    readonly SUPABASE_URL: string;
    readonly SUPABASE_SERVICE_ROLE_KEY: string;
    readonly GOOGLE_SERVICE_ACCOUNT_KEY_ID: string;
    readonly GOOGLE_SERVICE_EMAIL: string;
    readonly GOOGLE_SERVICE_ACCOUNT_KEY: string;

    //singleton
    private static instance: Env | null = null;

    private constructor() {
        this.SUPABASE_URL = Deno.env.get("SUPABASE_URL");
        this.SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
        this.GOOGLE_SERVICE_ACCOUNT_KEY_ID = Deno.env.get("GOOGLE_SERVICE_ACCOUNT_KEY_ID"),
        this.GOOGLE_SERVICE_EMAIL = Deno.env.get("GOOGLE_SERVICE_EMAIL"),
        this.GOOGLE_SERVICE_ACCOUNT_KEY = Deno.env.get("GOOGLE_SERVICE_ACCOUNT_KEY").replaceAll('\\n', '\n')
    }

    static i(): Env{
        if (Env.instance === null) {
            Env.instance = new Env();
        }
    
        return Env.instance;
    } 
}