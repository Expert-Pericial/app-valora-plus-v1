-- Create documents bucket for PDF uploads
INSERT INTO storage.buckets (id, name)
VALUES (
  'documents',
  'documents'
) ON CONFLICT (id) DO NOTHING;