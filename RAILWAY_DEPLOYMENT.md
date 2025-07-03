# Deploying Polis on Railway

This guide will help you deploy Polis on Railway.com, a modern platform for deploying applications.

## Prerequisites

1. A Railway account (free tier available)
2. Git repository with your Polis code
3. Basic understanding of environment variables

## Step 1: Prepare Your Repository

The following files have been created for Railway deployment:

- `railway.json` - Railway configuration
- `Dockerfile.railway` - Server-only Dockerfile for Railway
- `railway.env.example` - Example environment variables

## Important Note: Server-Only Deployment

This Railway deployment focuses on running the **Polis server** only. This is the most critical component and will give you a working Polis instance with:

✅ **Working features:**
- User registration and authentication
- Conversation creation and management
- Comment submission and voting
- Basic math calculations
- API endpoints

⚠️ **Limited features:**
- Advanced AI features (Delphi service)
- Complex mathematical analysis (Math service)
- Static file serving (File server)

For a full-featured deployment, you would need to run the additional services (Math, Delphi, File server) separately or use a different platform that supports multi-service deployments.

## Step 2: Deploy to Railway

### Option A: Deploy via Railway CLI

1. Install Railway CLI:
   ```bash
   npm install -g @railway/cli
   ```

2. Login to Railway:
   ```bash
   railway login
   ```

3. Initialize your project:
   ```bash
   railway init
   ```

4. Deploy your application:
   ```bash
   railway up
   ```

### Option B: Deploy via GitHub Integration

1. Go to [Railway Dashboard](https://railway.app/dashboard)
2. Click "New Project"
3. Select "Deploy from GitHub repo"
4. Connect your GitHub account and select your Polis repository
5. Railway will automatically detect the `railway.json` configuration

## Step 3: Configure Environment Variables

1. In your Railway project dashboard, go to the "Variables" tab
2. Add the following essential environment variables:

### Required Variables

```bash
# Railway automatically provides these
RAILWAY_PUBLIC_DOMAIN=your-app-name.railway.app
PORT=5000

# Essential Polis configuration
NODE_ENV=production
DEV_MODE=false
MATH_ENV=prod
DATABASE_SSL=true
CACHE_MATH_RESULTS=true

# Domain configuration
API_PROD_HOSTNAME=${RAILWAY_PUBLIC_DOMAIN}
EMBED_SERVICE_HOSTNAME=${RAILWAY_PUBLIC_DOMAIN}
DOMAIN_OVERRIDE=${RAILWAY_PUBLIC_DOMAIN}
SERVICE_URL=https://${RAILWAY_PUBLIC_DOMAIN}

# Admin configuration
ADMIN_UIDS=[]
ADMIN_EMAILS=[]
POLIS_FROM_ADDRESS="Polis <noreply@polis.com>"

# Email configuration
EMAIL_TRANSPORT_TYPES=maildev

# Logging
MATH_LOG_LEVEL=warn
SERVER_LOG_LEVEL=warn

# Internal service credentials
WEBSERVER_USERNAME=ws-user
WEBSERVER_PASS=ws-pass

# Translation API (optional)
SHOULD_USE_TRANSLATION_API=false
```

### Optional Variables

Add these if you want to use specific features:

```bash
# Third-party service API keys
AKISMET_ANTISPAM_API_KEY=your_akismet_key
GA_TRACKING_ID=your_ga_tracking_id
MAILGUN_API_KEY=your_mailgun_key
MAILGUN_DOMAIN=your_mailgun_domain
AWS_REGION=us-east-1
AWS_ACCESS_KEY_ID=your_aws_key
AWS_SECRET_ACCESS_KEY=your_aws_secret
ANTHROPIC_API_KEY=your_anthropic_key
GEMINI_API_KEY=your_gemini_key
OPENAI_API_KEY=your_openai_key
```

## Step 4: Add PostgreSQL Database

1. In your Railway project, click "New Service"
2. Select "Database" → "PostgreSQL"
3. Railway will automatically provide the `DATABASE_URL` environment variable
4. The Polis application will automatically connect to this database

## Step 5: Configure Custom Domain (Optional)

1. In your Railway project settings, go to "Domains"
2. Add your custom domain
3. Update the environment variables to use your custom domain:
   ```bash
   API_PROD_HOSTNAME=your-domain.com
   EMBED_SERVICE_HOSTNAME=your-domain.com
   DOMAIN_OVERRIDE=your-domain.com
   SERVICE_URL=https://your-domain.com
   ```

## Step 6: Deploy and Test

1. Railway will automatically build and deploy your application
2. Monitor the deployment logs in the Railway dashboard
3. Once deployed, visit your Railway URL (e.g., `https://your-app-name.railway.app`)
4. Create an admin user by visiting `/createuser`

## Step 7: Set Up Admin Users

1. Visit your deployed Polis instance
2. Go to `/createuser` to create your first admin account
3. Update the `ADMIN_UIDS` environment variable with your user ID
4. Update the `ADMIN_EMAILS` environment variable with your email

## Troubleshooting

### Common Issues

1. **Build Failures**: 
   - Check the build logs in Railway dashboard
   - Ensure all required files are present in your repository
   - Verify Dockerfile paths are correct

2. **Database Connection**: 
   - Ensure `DATABASE_URL` is properly set
   - Check that PostgreSQL service is running
   - Verify SSL settings if using external database

3. **Port Issues**: 
   - Make sure `PORT` is set to 5000
   - Check that the port is exposed in Dockerfile

4. **Domain Issues**: 
   - Verify all domain-related environment variables are set correctly
   - Check that `RAILWAY_PUBLIC_DOMAIN` is available

5. **Health Check Failures**:
   - The health check looks for `/api/v3/status` endpoint
   - Make sure the server is starting correctly
   - Check server logs for any startup errors

### Logs and Monitoring

- View application logs in the Railway dashboard
- Monitor resource usage and performance
- Set up alerts for critical issues

### Scaling

Railway automatically scales your application based on traffic. You can also manually adjust resources in the Railway dashboard.

## Security Considerations

1. **Environment Variables**: Never commit sensitive information to your repository
2. **Database**: Use Railway's managed PostgreSQL for production
3. **SSL**: Railway provides automatic SSL certificates
4. **API Keys**: Store all API keys as environment variables

## Cost Optimization

1. **Free Tier**: Railway offers a generous free tier
2. **Resource Limits**: Monitor your usage to avoid unexpected charges
3. **Auto-scaling**: Railway automatically scales down during low traffic

## Support

- Railway Documentation: https://docs.railway.app/
- Polis Documentation: https://compdemocracy.org/Welcome
- Railway Community: https://community.railway.app/

## Next Steps

After successful deployment:

1. Configure email services (Mailgun, AWS SES, etc.)
2. Set up monitoring and analytics
3. Configure backup strategies
4. Set up CI/CD pipelines
5. Configure custom domains and SSL certificates

## Upgrading to Full Deployment

If you need the full Polis functionality (AI features, advanced math, etc.), you have several options:

1. **Deploy additional services separately** on Railway or other platforms
2. **Use a different platform** that better supports multi-service deployments (like AWS ECS, Google Cloud Run, or DigitalOcean App Platform)
3. **Run the full stack locally** for development and testing

The server-only deployment gives you a solid foundation to build upon and test the core Polis functionality. 